## Container Entrypoint Script
This script demonstrates running shell commands in a Docker container, 
before running the main executable for the container.

## Usage Example
### Base Docker File:
```
FROM alpine:latest

COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
```

The `docker build` command must be run outside of the Dockerfile directory, using `-f` arg, to specifiy the docker-file and its directory. This is because the build context is limited to the current directory the command is run from, but includes its child directories.

### The Main Executable:
You have two options:

1. Add the exectuable you want to run during the `docker run` command, i.e. `docker run <image name> bash`
2. Add `CMD` to the base or inheriting Docker file of the image, i.e. `CMD ["bash"]`
