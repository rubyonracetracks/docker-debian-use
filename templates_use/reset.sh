#!/bin/bash

DOCKER_IMAGE='<DOCKER_IMAGE>'
CONTAINER='<CONTAINER>'

wget -O - https://gitlab.com/rubyonracetracks/docker-common/raw/main/delete-containers.sh | bash -s "$CONTAINER"

sh container_create.sh $DOCKER_IMAGE $CONTAINER
sh container_start.sh $DOCKER_IMAGE $CONTAINER
