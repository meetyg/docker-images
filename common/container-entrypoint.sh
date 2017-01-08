#! /bin/bash

#####################
# helper functions: #
#####################

CONTAINER_ENTRYPOINT_SCRIPT_VERSION=2.0

warnMsg () {
 echo -e "\e[1;33mWARNING: \e[0m$1\e[0m"
 
 return 0
}

infoMsg () {
  echo -e "\e[1;34mINFO: \e[0m$1\e[0m"
 
 return 0
}

printVersion() {
	infoMsg "########################################################"
	infoMsg "Runing Container Entrypoint Script (ver: $CONTAINER_ENTRYPOINT_SCRIPT_VERSION)"
	infoMsg "########################################################"
	
	return 0
}

#####################

printVersion

if [ -e "/proc/self/cgroup" ]; then
	DOCKER_CID=$(cat /proc/self/cgroup | grep 'docker' | sed 's/^.*\///' | tail -n1)
fi

if [ ${#DOCKER_CID} = 64 ]; then
		infoMsg "Running container with id: \e[1;34m$DOCKER_CID\e[0m"
		
		if [ ${#LOGS_PATH} -lt 2 ]; then # Prevents . or /
			warnMsg "LOGS_PATH is not set, logs will not be collected."
		else			
			if [ ! -d "/mnt/logs" ]; then
				warnMsg "Logs directory \e[1;34m/mnt/logs\e[0m is not mounted, logs will not be collected."
			else
				# Create logs directory on mounted logs dir for this container
				mkdir -p /mnt/logs/$DOCKER_CID
				
				# Make sure directory tree up to logs directory exists
				mkdir -p $LOGS_PATH

				# Remove existing local logs dir (keeping tree up to the directory). This is mandatory for the symlink to work.
				rm -rf $LOGS_PATH

				infoMsg "Linking logs directory:"
				
				# SymLink the mounted logs dir with conatiner id to the local logs dir
				ln -v -s /mnt/logs/$DOCKER_CID $LOGS_PATH
			fi
		fi
else
	warnMsg "Unable to get container id, logs will not be collected."
fi		

#echo "params: $@"

# Check if configs dir is mounted:
if [ ! -d "/mnt/config" ]; then
	if [ ${#DEFAULT_CONFIG_FILE_PATH} -lt 2 ]; then # Prevents . or /
		warnMsg "DEFAULT_CONFIG_FILE_PATH is not set."
		warnMsg "Config directory \e[1;34m/mnt/config\e[0m is not mounted, using container default configuration."
	else
		warnMsg "Config directory \e[1;34m/mnt/config\e[0m is not mounted, using default configuration from $DEFAULT_CONFIG_FILE_PATH"
	fi
fi

if [ -n "$*" ]
	then
		infoMsg "Executing \e[1;34m$@"
		
		# Run the command passed as argument to this container.
		exec "$@"
		
	else
		warnMsg "Nothing to execute, no command specified."
fi
