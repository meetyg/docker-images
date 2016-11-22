## Known Issues
1) When running this image, you may get the following error:
```
max virtual memory areas vm.max_map_count [65530] likely too low, increase to at least [262144]
```
In order to fix this, the following command need to be run on the Docker *host* computer:
```
sysctl -w vm.max_map_count=262144
```

2) Logging: The default log4j configuration in the Elasticsearch 5.0 Docker image is to log to console only.
This means that no log files will appear at the logs directory.
This can be fixed by changing the log4j config file in the image.
Logs can be seen using ```docker logs <container_id>```
