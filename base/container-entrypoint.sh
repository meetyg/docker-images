#!/bin/sh

if [ -z "$LOGS_PATH" ]
 then
    echo "Warning: LOGS_PATH is not set."
 else
	
	if [ ! -d "/mnt/logs" ]
	 then
	    echo "Warning: Logs dir (/mnt/logs) is not mounted."
	else
		# Create logs directory on mounted logs dir for this container
		mkdir -p /mnt/logs/$HOSTNAME

		# Remove existing local logs dir. This is mandatory for the symlink to work.
		rm -rf $LOGS_PATH

		# SymLink the mounted logs dir with conatiner id to the local logs dir
		ln -v -s /mnt/logs/$HOSTNAME $LOGS_PATH
	fi

fi  

#echo "Running $@"
# Run the command passed as argument, after this script:
exec "$@"
