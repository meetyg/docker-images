#!/bin/sh

# Create logs directory on mounted logs dir for this container
mkdir -p /mnt/logs/$HOSTNAME

# Remove existing local logs dir. This is mandatory for the symlink to work.
rm -rf $LOGS_PATH

# SymLink the mounted logs dir with conatiner id to the local logs dir
ln -s /mnt/logs/$HOSTNAME $LOGS_PATH

#echo "Running $@"
# Run the command passed as argument, after this script:
exec "$@"
