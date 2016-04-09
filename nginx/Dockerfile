FROM nginx:stable

LABEL Description="Base Nginx docker image" \
      OSImage="debian:jessie" \ 
      ImageVersion="1.0" \ 
      NginxVersion="latest stable"  \
	  LogCollectionMethod="logfiles"
	  

# Remove symlink of log files to stdout in original image
RUN rm -f /var/log/nginx/access.log && \
    rm -f /var/log/nginx/error.log

# Set LOGS_PATH environment variable for log collecting.
ENV LOGS_PATH=/var/log/nginx
	
COPY ../base/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
