#!/bin/bash

DISTRO='debian'
DOCKER_IMAGE="ghcr.io/$OWNER/docker-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"
WORK_DIR="tmp/$ABBREV/$SUITE"

bash setup.sh $ABBREV $SUITE $DOCKER_IMAGE $CONTAINER

cd $WORK_DIR

bash container_create.sh $DOCKER_IMAGE $CONTAINER
