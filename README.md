# shared-feed-relay

Tailnet-only TCP relay for a shared-in feed source.

The Tailscale sidecar intentionally does not advertise tags. Shared-in machines are visible to user-owned nodes, not tagged nodes, so tagging this relay would prevent it from seeing the upstream desktop.

## Environment

```env
TS_AUTHKEY=
TS_HOSTNAME=shared-feed-relay
TARGET_HOST=100.64.19.108
TARGET_PORT=12001
LISTEN_PORT=12002
CONNECT_TIMEOUT_SECONDS=10
```

Clients should connect to the relay tailnet address on `LISTEN_PORT`; the WebSocket path is passed through unchanged.
