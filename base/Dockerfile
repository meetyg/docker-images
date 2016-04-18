FROM alpine:latest

RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]