#!/bin/bash

ABBREV='min-stage1'
OWNER='rubyonracetracks'
DISTRO='debian'
SUITE='trixie'
DOCKER_IMAGE="ghcr.io/$OWNER/docker-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"

bash setup.sh $ABBREV $SUITE $DOCKER_IMAGE $CONTAINER
