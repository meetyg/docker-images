FROM fluent/fluentd:stable-onbuild

LABEL Description="Fluentd docker image" \
      BaseImageOS="alpine" \ 
      ImageBuildNumber="1" \ 
      BaseImageVersion="0.12.33" \
	  BaseImageName="fluentd:stable-onbuild" \
	  LogCollectionMethod="stdout"

# Add config files
COPY fluent.conf /fluentd/etc/
COPY config.d/ /fluentd/etc/config.d

# Install plugins
#RUN fluent-gem-install /fluentd/plugins/*.gem --no-ri --no-rdoc

# Create directory for fluentd position files
#RUN mkdir -p /mnt/logs/td-agent/pos


