FROM buildpack-deps:jessie-curl

# filebeats installation instructions taken from: 
# https://www.elastic.co/guide/en/beats/libbeat/5.1/setup-repositories.html

# Download and install the Public Signing Key of Elasticsearch:
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# Add support for APT HTTPS:
RUN sudo apt-get install apt-transport-https

# Save the repository definition to /etc/apt/sources.list.d/elastic-5.x.list:
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

# Install filebeat
RUN sudo apt-get update && sudo apt-get install filebeat

# Configure the beat to start automatically during boot:
RUN sudo update-rc.d filebeat defaults 95 10


