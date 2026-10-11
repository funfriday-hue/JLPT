#!/usr/bin/env bash

set -Eeuo pipefail

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
umask 077

# Keep credentials outside the repository. See mysql-backup.cnf.example.
MYSQL_DEFAULTS_FILE="${MYSQL_DEFAULTS_FILE:-/etc/jlptquiz/mysql-backup.cnf}"
DATABASE_NAME="${DATABASE_NAME:-jlptquiz}"
AUDIO_VOLUME="${AUDIO_VOLUME:-jlpt_chirp_audio}"
RCLONE_REMOTE="${RCLONE_REMOTE:-FunFriday:}"
REMOTE_FILE="${REMOTE_FILE:-${RCLONE_REMOTE}JLPTQuizBackups/jlptquiz-latest.tar.gz}"
LOCK_FILE="${LOCK_FILE:-/var/lock/jlptquiz-backup.lock}"

for required_command in docker flock gzip mysqldump rclone sha256sum tar; do
  if ! command -v "$required_command" >/dev/null 2>&1; then
    echo "Required command was not found: $required_command" >&2
    exit 1
  fi
done

if [[ ! -r "$MYSQL_DEFAULTS_FILE" ]]; then
  echo "MySQL credentials file is missing or unreadable: $MYSQL_DEFAULTS_FILE" >&2
  exit 1
fi

exec 9>"$LOCK_FILE"
if ! flock -n 9; then
  echo "Another JLPT Quiz backup is already running; skipping this run."
  exit 0
fi

audio_mountpoint="$(docker volume inspect --format '{{ .Mountpoint }}' "$AUDIO_VOLUME")"
if [[ -z "$audio_mountpoint" || ! -d "$audio_mountpoint/questions" ]]; then
  echo "Chirp audio was not found in Docker volume: $AUDIO_VOLUME" >&2
  exit 1
fi

work_directory="$(mktemp -d /var/tmp/jlptquiz-backup.XXXXXX)"
staging_directory="$work_directory/staging"
backup_bundle="$work_directory/jlptquiz-latest.tar.gz"
mkdir -p "$staging_directory"
trap 'rm -rf -- "$work_directory"' EXIT

mysqldump --defaults-extra-file="$MYSQL_DEFAULTS_FILE" \
  --single-transaction \
  --no-tablespaces \
  --routines \
  --events \
  --triggers \
  --set-gtid-purged=OFF \
  --databases "$DATABASE_NAME" \
  | gzip -c > "$staging_directory/jlptquiz.sql.gz"

tar -czf "$staging_directory/chirp-audio.tar.gz" -C "$audio_mountpoint" .

{
  echo "created_at_utc=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
  echo "database=$DATABASE_NAME"
  echo "audio_volume=$AUDIO_VOLUME"
  echo
  sha256sum "$staging_directory/jlptquiz.sql.gz" "$staging_directory/chirp-audio.tar.gz" \
    | sed "s|$staging_directory/||"
} > "$staging_directory/MANIFEST.txt"

tar -czf "$backup_bundle" -C "$staging_directory" \
  MANIFEST.txt jlptquiz.sql.gz chirp-audio.tar.gz

if [[ ! -s "$backup_bundle" ]]; then
  echo "Backup bundle is empty." >&2
  exit 1
fi

# copyto replaces the previous successful daily backup at this fixed path.
rclone copyto "$backup_bundle" "$REMOTE_FILE"

echo "JLPT Quiz backup completed: $REMOTE_FILE"
