FROM java:8-jre

LABEL Description="Java (OpenJDK 8) docker image" \
      OSImage="debain:jessie" \ 
      ImageVersion="1.0" \ 
      JavaVersion="8-jre"


COPY ../base/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
