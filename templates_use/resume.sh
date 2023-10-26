#!/bin/bash

CONTAINER='<CONTAINER>'

# Check for regular user login
if [ ! $( id -u ) -ne 0 ]; then
  echo 'You must be a regular user to run this script.'
  exit 2
fi

echo '******'
echo 'NOTICE'
echo '1. If this resume.sh script does not work, then there is probably no'
echo 'container to resume.  You likely need to run the reset.sh script first.'
echo '2. If you are connected to two Docker containers from the same image '
echo 'simultaneously, changes in one container (outside of the shared folder) '
echo 'do not propagate to the other.  Use the join.sh script for multi-shell '
echo 'access to the same container.'
echo
echo '------------------------------------'
echo "Starting Docker container $CONTAINER"
wait
docker start -i $CONTAINER

