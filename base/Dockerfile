FROM alpine:latest # Just for the example

COPY container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
