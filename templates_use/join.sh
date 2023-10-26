#!/bin/bash

CONTAINER='<CONTAINER>'

# Check for regular user login
if [ ! $( id -u ) -ne 0 ]; then
  echo 'You must be a regular user to run this script.'
  exit 2
fi

echo '******'
echo 'NOTICE'
echo 'If this join.sh script does not work, then there is probably no'
echo 'running container to join.  You likely need to run the'
echo 'download_new_image.sh, reset.sh, or resume.sh script first.'
echo

IS='/bin/bash -l' # Initial script to run

echo '------------------------------------------'
echo "Joining Docker container $DOCKER_CONTAINER"
wait
docker exec -it $CONTAINER $IS
