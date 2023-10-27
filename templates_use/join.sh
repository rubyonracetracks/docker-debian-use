#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

source variables.sh

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
