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

echo '*****************************************************************'
echo "If $DOCKER_IMAGE does not download, these are the likely reasons:"
echo '1. It is not available.'
echo '2. You have downstream images that depend on your current image.  Use the nuke.sh script to remove all local Docker images.'
echo
echo 'Press Enter to continue.'
read -p '************************' continue

wget -O - https://gitlab.com/rubyonracetracks/docker-common/raw/main/delete-containers.sh | bash -s "$CONTAINER"
wget -O - https://gitlab.com/rubyonracetracks/docker-common/raw/main/delete-images.sh | bash -s "$DOCKER_IMAGE"

bash download-image.sh
bash container-create.sh
bash container-start.sh
bash join.sh
