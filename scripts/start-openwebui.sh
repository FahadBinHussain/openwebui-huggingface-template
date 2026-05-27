#!/usr/bin/env bash
set -euo pipefail

export HOST="${HOST:-0.0.0.0}"
export PORT="${PORT:-7860}"
export DATA_DIR="${DATA_DIR:-/data/open-webui}"

mkdir -p "$DATA_DIR"

if [[ -n "${LITELLM_BASE_URL:-}" && -z "${OPENAI_API_BASE_URLS:-}" ]]; then
  export OPENAI_API_BASE_URLS="$LITELLM_BASE_URL"
fi

if [[ -n "${LITELLM_API_KEY:-}" && -z "${OPENAI_API_KEYS:-}" ]]; then
  export OPENAI_API_KEYS="$LITELLM_API_KEY"
fi

cd /app/backend
exec bash start.sh "$@"
