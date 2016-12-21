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

#####################
#imgdirs=("elasticsearch" "fluentd" "javabase" "kibana" "nginx" "nodejs")
imgdirs=("elasticsearch")
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
	docker build --pull -f "$dirname/Dockerfile" -t "$prefix$dirname" .
	
	tag=$(docker inspect --format='{{.ContainerConfig.Labels.ImageVersion}}' "$prefix$dirname")
	
	if [ -n "$tag" ]; then
		infoMsg "Tagging image: \e[1;34m$prefix$dirname\e[0m with tag: \e[1;34m$tag\e[0m"
		tag=":$tag"
		docker tag "$prefix$dirname:latest" "$prefix$dirname$tag" 
		# Remove "latest" tag, to prevent unintentional use
		docker rmi "$prefix$dirname:latest"
	else
		warnMsg "No tag found for: \e[1;34m$prefix$dirname\e[0m , make sure ImageVersion label exists in the Dockerfile."
	fi
	
	infoMsg "Saving Docker image \e[1;34m$prefix$dirname$tag\e[0m as \e[1;34m${prefix: : -1}_${dirname}_${tag:1}.tar\e[0m"
	docker save -o "${prefix: : -1}_${dirname}_${tag:1}.tar" "$prefix$dirname$tag"
done

infoMsg "Done!"