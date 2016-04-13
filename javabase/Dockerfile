FROM java:8-jre

LABEL Description="Java (OpenJDK 8) docker base image" \
      OSImage="debian:latest" \ 
      ImageVersion="1.0" \ 
      JavaVersion="8-jre" \
      LogCollectionMethod="logfiles"


COPY ../base/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
