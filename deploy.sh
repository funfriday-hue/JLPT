#!/usr/bin/env bash

set -Eeuo pipefail

trap 'echo "Deployment failed on line ${LINENO}." >&2' ERR

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$script_dir"

if ! command -v git >/dev/null 2>&1; then
  echo "Git is required but was not found." >&2
  exit 1
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Docker is required but was not found." >&2
  exit 1
fi

if ! docker compose version >/dev/null 2>&1; then
  echo "Docker Compose v2 is required. Install the Docker Compose plugin." >&2
  exit 1
fi

if [[ ! -f .env ]]; then
  echo "Missing $script_dir/.env. Create it from .env.example before deploying." >&2
  exit 1
fi

current_branch="$(git branch --show-current)"
if [[ -z "$current_branch" ]]; then
  echo "Deployment requires a checked-out Git branch; detached HEAD is not supported." >&2
  exit 1
fi

echo "Pulling the latest origin/$current_branch changes..."
git pull --ff-only origin "$current_branch"

echo "Validating Docker Compose configuration..."
docker compose config --quiet

echo "Building and starting JLPT Quiz..."
docker compose up -d --build --remove-orphans

echo "Current container status:"
docker compose ps

echo "Deployment completed. Health endpoint: http://127.0.0.1:3200/api/health"
