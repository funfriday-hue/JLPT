# JLPT Quiz backup

The independent `jlptquiz-backup` cron job runs daily at 12:30 AM server time.
It creates one bundle containing:

- a compressed `jlptquiz` MySQL dump;
- the generated MP3 files from the `jlpt_chirp_audio` Docker volume;
- a manifest with UTC creation time and SHA-256 checksums.

By default, rclone uploads the bundle to
`FunFriday:JLPTQuizBackups/jlptquiz-latest.tar.gz`. The fixed name replaces the
previous successful backup instead of accumulating files. This job does not
modify the FunFriday repository or its backup configuration.

## Configure

`deploy.sh` installs the script, cron file, and—only when it does not already
exist—a credentials template. Set the actual MySQL user and raw password after
the first deployment:

```bash
sudo nano /etc/jlptquiz/mysql-backup.cnf
sudo chmod 600 /etc/jlptquiz/mysql-backup.cnf
```

The MySQL user needs permission to dump the `jlptquiz` database. Confirm that
the root account running cron can see the existing rclone remote:

```bash
sudo rclone listremotes
```

If the remote is not called `FunFriday:`, override `RCLONE_REMOTE` in the cron
line or script environment. `DATABASE_NAME`, `AUDIO_VOLUME`, `REMOTE_FILE`,
`MYSQL_DEFAULTS_FILE`, and `LOCK_FILE` can also be overridden.

## Test

Run one backup manually and confirm the uploaded bundle:

```bash
sudo /usr/local/sbin/jlptquiz-backup
sudo rclone ls FunFriday:JLPTQuizBackups
```

View scheduled-run output with:

```bash
sudo tail -n 200 /var/log/jlptquiz-backup.log
```

## Restore

Download and unpack the latest bundle into a temporary directory. Restore the
database only after reviewing the dump and selecting the correct destination:

```bash
rclone copyto FunFriday:JLPTQuizBackups/jlptquiz-latest.tar.gz /var/tmp/jlptquiz-latest.tar.gz
mkdir -p /var/tmp/jlptquiz-restore
tar -xzf /var/tmp/jlptquiz-latest.tar.gz -C /var/tmp/jlptquiz-restore
gzip -dc /var/tmp/jlptquiz-restore/jlptquiz.sql.gz | mysql --defaults-extra-file=/etc/jlptquiz/mysql-backup.cnf
```

Restore audio into the existing volume mountpoint:

```bash
audio_mountpoint="$(docker volume inspect --format '{{ .Mountpoint }}' jlpt_chirp_audio)"
tar -xzf /var/tmp/jlptquiz-restore/chirp-audio.tar.gz -C "$audio_mountpoint"
```

Do not commit `/etc/jlptquiz/mysql-backup.cnf`, the rclone configuration, or
service-account keys.
