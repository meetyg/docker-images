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

				infoMsg "Linking logs directory \e[1;34m$LOGS_PATH\e[0m"
				
				# SymLink the mounted logs dir with conatiner id to the local logs dir
				ln -v -s /mnt/logs/$DOCKER_CID $LOGS_PATH
			fi
		fi
else
	warnMsg "Unable to get container id, logs will not be collected."
fi		

#echo "params: $@"

# Check if default config file path is set in container:
if [ ${#DEFAULT_CONFIG_FILE_PATH} -lt 2 ]; then # Prevents . or /
	warnMsg "Environment variable \e[1;34mDEFAULT_CONFIG_FILE_PATH\e[0m is not set !"
else
	# Make sure default config file path really exists:
	if [ ! -f "$DEFAULT_CONFIG_FILE_PATH" ]; then
		warnMsg "Default config file \e[1;34m$DEFAULT_CONFIG_FILE_PATH\e[0m does not exist !"
	else
		# Check if configs dir is mounted:
		if [ ! -d "/mnt/config" ]; then
			warnMsg "Config directory \e[1;34m/mnt/config\e[0m is not mounted, using default configuration from $DEFAULT_CONFIG_FILE_PATH"
		else
			CONFIG_DIR_PATH=$(dirname "${DEFAULT_CONFIG_FILE_PATH}")

			# Make sure directory tree up to config directory exists
			mkdir -p $CONFIG_DIR_PATH

			# Remove existing local logs dir (keeping tree up to the directory). This is mandatory for the symlink to work.
			rm -rf $CONFIG_DIR_PATH

			infoMsg "Linking configuration directory \e[1;34m$CONFIG_DIR_PATH\e[0m"

			# SymLink the mounted logs dir with conatiner id to the local logs dir
			ln -v -s /mnt/config $CONFIG_DIR_PATH
		fi
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
