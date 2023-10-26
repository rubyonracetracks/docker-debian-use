#!/bin/bash

CONTAINER='<CONTAINER>'

wait
echo '------------------------------------'
echo "Starting Docker container $CONTAINER"
docker start -i $CONTAINER
