## Container Entrypoint Script
This script demonstrates running shell commands in a Docker container, 
before running the main executable for the container.

## Usage Example
### Base Docker File:
```
FROM alpine:latest

COPY container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
```
### The Main Executable:
You have two options:

1. Add the exectuable you want to run during the `docker run` command, i.e. `docker run <image name> bash`
2. Add `CMD` to the base or inheriting Docker file of the image, i.e. `CMD ["bash"]`
