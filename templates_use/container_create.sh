#!/bin/bash

DOCKER_IMAGE='<DOCKER_IMAGE>'
CONTAINER='<CONTAINER>'

# NOTE: Without the "-l" flag, the default Ruby version is the one
# installed with apt-get instead of the one installed with RVM.
is='/bin/bash -l' # Initial script to run
hs=$PWD/shared # Host machine shared directory
ds='/home/winner/shared' # Docker shared directory

echo '-------------------------------------------------------'
echo "Creating Docker container $CONTAINER from $DOCKER_IMAGE"
docker create -i -t -u='winner' --name $CONTAINER \
  #PORT_SPECIFICATIONS_HERE \
  -e HOME=/home/winner -e USERNAME=winner \
  -v $hs:$ds $DOCKER_IMAGE $is
wait
