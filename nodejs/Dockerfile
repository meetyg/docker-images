FROM node:slim


LABEL Description="NodeJS docker image (slim version)" \
      OSImage="debian:jessie" \ 
      ImageVersion="1.0" \ 
      NodeJSVersion="latest slim"

COPY ../base/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
