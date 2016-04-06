FROM alpine:latest

COPY container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ONBUILD ENTRYPOINT ["/container-entrypoint.sh"]
