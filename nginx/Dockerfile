FROM nginx:stable-alpine

LABEL Description="Base Nginx docker image" \
      OSImage="alpine:latest" \ 
      ImageVersion="1.0" \ 
      NginxVersion="latest stable"

# Remove symlink of log files to stdout in original image
RUN rm -f /var/log/nginx/access.log && \
    rm -f /var/log/nginx/error.log

# Add config files when this image is inherited from
ONBUILD COPY nginx.conf /etc/nginx/nginx.conf
