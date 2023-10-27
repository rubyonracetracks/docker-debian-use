#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

mkdir -p tmp

# Parameter files
echo "$ABBREV" > tmp/ABBREV.txt
echo "$SUITE" > tmp/SUITE.txt
echo "$OWNER" > tmp/OWNER.txt
echo "$DISTRO" > tmp/DISTRO.txt

bash setup.sh
wait
cd "tmp/$ABBREV/$SUITE"
wait
bash container_create.sh
wait
source variables.sh
wait
docker exec -it $CONTAINER '/usr/local/bin/check'
wait
