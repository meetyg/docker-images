#! /bin/bash

#####################
# helper functions: #
#####################


warnMsg () {
 echo -e "\e[1;33mWARNING: \e[0m$1\e[0m"
 
 return 0
}

infoMsg () {
  echo -e "\e[1;34mINFO: \e[0m$1\e[0m"
 
 return 0
}

errMsg () {
 echo -e "\e[1;31mERROR: \e[0m$1\e[0m"
 
 return 0
}

#####################


if [ ! -n "$2" ]; then
	imgdirs=("elasticsearch" "filebeat" "fluentd" "neo4j" "javabase" "kibana" "nginx" "nodejs")
else
	imgdirs=("$2")
fi



prefix=""
tag=""

if [ -n "$1" ]; then
	prefix="$1/"
	infoMsg "Building Docker images with \e[1;34m$prefix\e[0m prefix..."
	
else
	warnMsg "No prefix specified, building Docker images without prefix!"
fi


for dirname in "${imgdirs[@]}"
do
	infoMsg "Building \e[1;34m$dirname\e[0m image..."
	docker build --pull -t "$prefix$dirname" $dirname
	status=$?
		   
    if [ $status -ne 0 ]; then
		errMsg "Docker build command failed, see output above."
		exit $status
	fi
	
	baseImageVersion=$(docker inspect --format='{{if .ContainerConfig.Labels.BaseImageVersion}}{{.ContainerConfig.Labels.BaseImageVersion}}{{end}}' "$prefix$dirname")
	buildNumber=$(docker inspect --format='{{if .ContainerConfig.Labels.ImageBuildNumber}}{{.ContainerConfig.Labels.ImageBuildNumber}}{{end}}' "$prefix$dirname")
	
	if [ -n "$baseImageVersion" -a -n "$buildNumber" ]; then
		tag="${baseImageVersion}.b${buildNumber}"
	fi
	
	if [ -n "$tag" ]; then
		infoMsg "Tagging image: \e[1;34m$prefix$dirname\e[0m with tag: \e[1;34m$tag\e[0m"
		tag=":$tag"
		docker tag "$prefix$dirname:latest" "$prefix$dirname$tag" 
		# Remove "latest" tag, to prevent unintentional use
		#docker rmi "$prefix$dirname:latest"
	else
		warnMsg "No tag found for: \e[1;34m$prefix$dirname\e[0m , make sure BaseImageVersion and ImageBuildNumber labels exist in the Dockerfile."
	fi
	
	infoMsg "Saving Docker image \e[1;34m$prefix$dirname$tag\e[0m as \e[1;34m${prefix: : -1}_${dirname}_${tag:1}.tar\e[0m"
	docker save -o "${prefix: : -1}_${dirname}_${tag:1}.tar" "$prefix$dirname$tag"
done

infoMsg "Done!"
