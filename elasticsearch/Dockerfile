FROM elasticsearch:5.0.1

LABEL Description="ElasticSearch docker image" \
      OSImage="debian:jessie" \ 
      ImageVersion="2.0" \ 
      ElasticsearchVersion="5.0.1" \
      LogCollectionMethod="logfiles"

# Set LOGS_PATH environment variable for log collecting.
ENV LOGS_PATH=/usr/share/elasticsearch/logs

COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

# Merging entrypoint with ElasticSearch entrypoint:
ENTRYPOINT ["/container-entrypoint.sh", "/docker-entrypoint.sh"]
CMD ["elasticsearch"]
