#!/bin/sh
set -eu

: "${TARGET_HOST:?TARGET_HOST is required}"
: "${TARGET_PORT:?TARGET_PORT is required}"

LISTEN_PORT="${LISTEN_PORT:-12002}"
CONNECT_TIMEOUT_SECONDS="${CONNECT_TIMEOUT_SECONDS:-10}"
TAILSCALE_SOCKET="${TAILSCALE_SOCKET:-/var/run/tailscale/tailscaled.sock}"

echo "[relay] target=${TARGET_HOST}:${TARGET_PORT} listen=:${LISTEN_PORT} connect_timeout=${CONNECT_TIMEOUT_SECONDS}s"

for _ in 1 2 3 4 5 6 7 8 9 10; do
  if [ -S "${TAILSCALE_SOCKET}" ]; then
    break
  fi
  sleep 1
done

if [ -S "${TAILSCALE_SOCKET}" ]; then
  echo "[relay] tailscale status:"
  tailscale --socket="${TAILSCALE_SOCKET}" status 2>&1 || true
else
  echo "[relay] tailscale socket missing at ${TAILSCALE_SOCKET}"
fi

echo "[relay] startup tcp probe:"
nc -vz -w "${CONNECT_TIMEOUT_SECONDS}" "${TARGET_HOST}" "${TARGET_PORT}" 2>&1 || true

exec socat -d -d "TCP-LISTEN:${LISTEN_PORT},fork,reuseaddr,bind=0.0.0.0" "TCP:${TARGET_HOST}:${TARGET_PORT},connect-timeout=${CONNECT_TIMEOUT_SECONDS}"
