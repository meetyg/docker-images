FROM buildpack-deps:jessie-curl

LABEL Description="ELK filebeat docker image" \
      BaseImageOS="debian:jessie" \ 
      ImageBuildNumber="1" \ 
      BaseImageVersion="5.1.1" \
      LogCollectionMethod="none"


# Set default configuration path.
ENV DEFAULT_CONFIG_FILE_PATH=/usr/share/elasticsearch/config/elasticsearch.yml
	

# filebeats installation instructions taken from: 
# https://www.elastic.co/guide/en/beats/libbeat/5.1/setup-repositories.html

# Download and install the Public Signing Key of Elasticsearch:
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -

# Add support for APT HTTPS:
RUN apt-get update && apt-get -y install apt-transport-https

# Save the repository definition to /etc/apt/sources.list.d/elastic-5.x.list:
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list

# Install filebeat
RUN apt-get update && apt-get -y install filebeat
