#!/bin/sh

#####################
# helper functions: #
#####################


warnMsg () {
  echo -e "\e[1;31mWARNING: \e[0m$1\e[0m"
 
 return 0
}

infoMsg () {
  echo -e "\e[1;34mINFO: \e[0m$1\e[0m"
 
 return 0
}

#####################

if [ -e "/proc/self/cgroup" ]
	then
		DOCKER_CID=$(cat /proc/self/cgroup | grep 'docker' | sed 's/^.*\///' | tail -n1)
fi

if [ ${#DOCKER_CID} == 64 ] 
	then
		infoMsg "Running container with id: $DOCKER_CID"
		
		
		if [ ${#LOGS_PATH} -lt 2 ] # Prevents . or /
		 then
			warnMsg "LOGS_PATH is not set, logs will not be collected."
		 else			
			if [ ! -d "/mnt/logs" ]
			 then
				warnMsg "Logs dir (/mnt/logs) is not mounted, logs will not be collected."
			else
				# Create logs directory on mounted logs dir for this container
				mkdir -p /mnt/logs/$DOCKER_CID

				# Remove existing local logs dir. This is mandatory for the symlink to work.
				rm -rf $LOGS_PATH

				infoMsg "Linking logs directory:"
				
				# SymLink the mounted logs dir with conatiner id to the local logs dir
				ln -v -s /mnt/logs/$DOCKER_CID $LOGS_PATH
			fi
		fi
else
	warnMsg "Unable to get container id, logs will not be collected."
fi		

if [ "$@" ] 
	then
		infoMsg "Executing \e[44m$@"
		
		# Run the command passed as argument to this container.
		exec "$@"
		
	else
		warnMsg "Nothing to execute, no command specified."
fi



