FROM alpine:3.8

RUN apk add --no-cache dhcp

ADD entrypoint.sh /entrypoint.sh

RUN chmod 750 /entrypoint.sh

CMD ["./entrypoint.sh"]