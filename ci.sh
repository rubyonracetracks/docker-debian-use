#!/bin/bash

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
