## Usage:
Example for mounting  Windows folders:
 `docker run -p 8000:80 -d -v /c/Users/AG/docker-images/log:/mnt/log -v /c/Users/AG/docker-images/html:/usr/share/nginx/html:ro test-nginx`
