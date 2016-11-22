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
imgdirs=("elasticsearch" "fluentd" "javabase" "kibana" "nginx" "nodejs")
prefix=""

if [ -n "$1" ]; then
	infoMsg "Building Docker images with \e[1;34m$1\e[0m prefix..."
	prefix="$1/"
else
	warnMsg "No prefix specified, building Docker images without prefix!"
fi

for dirname in "${imgdirs[@]}"
do
	infoMsg "Building \e[1;34m$dirname\e[0m image..."
	docker build --pull -f "$dirname/Dockerfile" -t "$prefix$dirname" .

	docker save -o "$prefix$dirname.tar" "$prefix$dirname"
done

