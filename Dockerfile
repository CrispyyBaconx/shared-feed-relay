FROM alpine:3.20

RUN apk add --no-cache socat busybox-extras

COPY relay.sh /usr/local/bin/relay.sh
RUN chmod +x /usr/local/bin/relay.sh

EXPOSE 12002

CMD ["relay.sh"]
