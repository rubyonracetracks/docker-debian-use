#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

source variables.sh

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
