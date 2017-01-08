FROM elasticsearch:5.0

LABEL Description="ElasticSearch docker image" \
      BaseImageOS="debian:jessie" \ 
      ImageBuildNumber="2" \ 
      BaseImageVersion="5.0" \
      LogCollectionMethod="logfiles"
	  
	  
# Set LOGS_PATH environment variable for log collecting.
ENV LOGS_PATH=/usr/share/elasticsearch/logs

# Set default configuration path.
ENV DEFAULT_CONFIG_FILE_PATH=/usr/share/elasticsearch/config/elasticsearch.yml
	
COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

# Merging entrypoint with ElasticSearch entrypoint:
ENTRYPOINT ["/container-entrypoint.sh", "/docker-entrypoint.sh"]
CMD ["elasticsearch"]
