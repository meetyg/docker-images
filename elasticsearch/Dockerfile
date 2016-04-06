FROM elasticsearch:latest

LABEL Description="ElasticSearch docker image" \
      OSImage="debian:jessie" \ 
      ImageVersion="1.0" \ 
      ElasticsearchVersion="latest"


COPY ../base/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
