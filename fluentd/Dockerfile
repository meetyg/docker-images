FROM fluent/fluentd:stable-debian-onbuild

LABEL Description="Fluentd docker image" \
      BaseImageOS="debian" \ 
      ImageBuildNumber="2" \ 
      BaseImageVersion="0.12.39" \
	  BaseImageName="fluentd:stable-debian-onbuild" \
	  LogCollectionMethod="stdout"

# Add config files
COPY fluent.conf /fluentd/etc/
COPY config.d/ /fluentd/etc/config.d


# Plugins will be auto copied by base image's ONBUILD command:
# Put plugins in 'plugins' dir so that they will be copied on build

# Install plugins
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && gem install /fluentd/plugins/*.gem --no-ri --no-rdoc \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem


