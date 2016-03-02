FROM ubuntu:trusty

### Installing td-agent from Treasuredata's apt/deb repo: ###
## Taken from Treasuredata's script for installing on Ubuntu 14.04:
## http://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh
## Edited to comply with Docker's Dockerfile best practices.

# Add treasuredata key to apt
RUN curl https://packages.treasuredata.com/GPG-KEY-td-agent | apt-key add -

# Add treasure data repository to apt
RUN echo "deb http://packages.treasuredata.com/2/ubuntu/trusty/ trusty contrib" > \
    /etc/apt/sources.list.d/treasure-data.list

# Run apt-get update and install td-agent from td repo (must be run on one line, best practice)
RUN apt-get update && apt-get install -y --force-yes td-agent

### End of td-install script

# Add config file
COPY td-agent.conf /etc/td-agent/

# Copy plugins:
COPY plugins/*.gem /etc/td-agent/plugin/
