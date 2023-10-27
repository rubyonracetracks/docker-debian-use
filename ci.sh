#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

DISTRO='debian'
DOCKER_IMAGE="ghcr.io/$OWNER/docker-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"
WORK_DIR="tmp/$ABBREV/$SUITE"

bash setup.sh $ABBREV $SUITE $DOCKER_IMAGE $CONTAINER
wait
cd $WORK_DIR
wait
bash container_create.sh $DOCKER_IMAGE $CONTAINER
wait
docker exec -it $CONTAINER '/usr/local/bin/check'
wait