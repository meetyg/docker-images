FROM nginx:stable

LABEL Description="Base Nginx docker image" \
      OSImage="debian:jessie" \ 
      ImageVersion="1.0" \ 
      NginxVersion="latest stable"

# Remove symlink of log files to stdout in original image
RUN rm -f /var/log/nginx/access.log && \
    rm -f /var/log/nginx/error.log
