FROM debian:jessie

LABEL Description="Fluentd (td-agent) docker image" \
      OSImage="debian:jessie" \ 
      ImageVersion="1.0" \ 
      FluentdVersion="latest stable (td-agent)"

### Installing td-agent from Treasuredata's apt/deb repo: ###
## Taken from Treasuredata's script for installing on Debian Jessie (8.3):
## https://td-toolbelt.herokuapp.com/sh/install-debian-jessie-td-agent2.sh
## Edited to comply with Docker's Dockerfile best practices.


# Add treasuredata key to apt
RUN apt-key adv --fetch-keys http://packages.treasuredata.com/GPG-KEY-td-agent

# Add treasure data repository to apt
RUN echo "deb http://packages.treasuredata.com/2/debian/jessie/ jessie contrib" > \
    /etc/apt/sources.list.d/treasure-data.list

# Run apt-get update and install td-agent from td repo (must be run on one line, best practice)
RUN apt-get update && apt-get install -y --force-yes td-agent

### End of td-install script

# clean cache files
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Add config files
COPY td-agent.conf /etc/td-agent/
COPY config.d/ /etc/td-agent/config.d

# Copy plugins:
COPY plugins/*.gem /etc/td-agent/plugin/

# Install plugins
RUN td-agent-gem install /etc/td-agent/plugin/*.gem --no-ri --no-rdoc

# Create directory for fluentd position files
RUN mkdir -p /var/log/td-agent/pos

# Run fluentd (td-agent)
ENTRYPOINT ["td-agent"]
