FROM nginx:1.10.2

LABEL Description="Base Nginx docker image" \
      BaseImageOS="debian:jessie" \ 
	  ImageBuildNumber="1" \ 
      BaseImageVersion="1.10.2"  \
	  BaseImageName="nginx" \
	  LogCollectionMethod="logfiles"
	  



# Remove symlink of log files to stdout in original image
RUN rm -f /var/log/nginx/access.log && \
    rm -f /var/log/nginx/error.log

# Set LOGS_PATH environment variable for log collecting.
ENV LOGS_PATH=/var/log/nginx

# Set default configuration path.
ENV DEFAULT_CONFIG_FILE_PATH=/etc/nginx/nginx.conf
	
COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
