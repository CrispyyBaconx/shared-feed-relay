FROM tailscale/tailscale:stable AS tailscale

FROM alpine:3.20

RUN apk add --no-cache socat busybox-extras

COPY --from=tailscale /usr/local/bin/tailscale /usr/local/bin/tailscale
COPY relay.sh /usr/local/bin/relay.sh
RUN chmod +x /usr/local/bin/relay.sh

EXPOSE 12002

CMD ["relay.sh"]
