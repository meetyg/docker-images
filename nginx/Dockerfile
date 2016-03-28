FROM nginx:stable-alpine

# Remove symlink of log files to stdout in original image
RUN rm -f /var/log/nginx/access.log && \
    rm -f /var/log/nginx/error.log
