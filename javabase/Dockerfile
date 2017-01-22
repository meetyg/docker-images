FROM openjdk:8-jre

LABEL Description="Java (OpenJDK 8) docker base image" \
      BaseImageOS="debian:jessie" \ 
      ImageBuildNumber="2" \ 
      BaseImageVersion="8-jre" \
	   BaseImageName="openjdk" \
      LogCollectionMethod="logfiles"


COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
