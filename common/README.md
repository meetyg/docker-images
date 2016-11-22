## Container Entrypoint Script
This script demonstrates running shell commands in a Docker container, 
before running the main executable for the container.

## Prerequisites
The container must have `bash` shell installed (most do have it).
If running on Alpine, or some other distro without `bash`, please take care to install
it on the container, as show in *Usage*.

## Usage Example
### Base Docker File:
```
FROM alpine:latest

# Install bash on Alpine
RUN apk add --update bash && rm -rf /var/cache/apk/*

COPY common/container-entrypoint.sh /
RUN chmod +x /container-entrypoint.sh

ENTRYPOINT ["/container-entrypoint.sh"]
```

The `docker build` command must be run outside of the Dockerfile directory, using `-f` arg, to specifiy the docker-file and its directory. This is because the build context is limited to the current directory the command is run from, but includes its child directories.

For example:
```
sudo docker build --pull -f elasticsearch/Dockerfile .
```
 
### The Main Executable:
You have two options:

1. Add the exectuable you want to run during the `docker run` command, i.e. `docker run <image name> bash`
2. Add `CMD` to the base or inheriting Docker file of the image, i.e. `CMD ["bash"]`
