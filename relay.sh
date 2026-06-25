#!/bin/sh
set -eu

: "${TARGET_HOST:?TARGET_HOST is required}"
: "${TARGET_PORT:?TARGET_PORT is required}"

LISTEN_PORT="${LISTEN_PORT:-12002}"
CONNECT_TIMEOUT_SECONDS="${CONNECT_TIMEOUT_SECONDS:-10}"

exec socat -d -d "TCP-LISTEN:${LISTEN_PORT},fork,reuseaddr,bind=0.0.0.0" "TCP:${TARGET_HOST}:${TARGET_PORT},connect-timeout=${CONNECT_TIMEOUT_SECONDS}"
