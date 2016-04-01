# nginx

## Description:
Dockerfile based on latest **stable** official nginx image.

This image is needed because in official nginx image, log files are linked to stdout, sterr.
This linking was removed, and log files are written to default nginx logs path.

## Usage:
- Nginx logs are written to default path: /var/logs/nginx
- Html files are served from default path: /usr/share/nginx/html

In order to serve html files, or read the logs (optional), these paths should be overlayed by Docker volumes on the host:

 `docker run -p 80:80 -d -v /mnt/log/nginx:/var/log/nginx -v /mnt/html:/usr/share/nginx/html:ro`
