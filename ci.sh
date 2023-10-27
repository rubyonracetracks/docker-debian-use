#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

mkdir -p tmp

# Parameter files
echo 'min-stage1' > tmp/ABBREV.txt
echo 'bookworm' > tmp/SUITE.txt
echo 'rubyonracetracks' > tmp/OWNER.txt
echo 'debian' > tmp/DISTRO.txt

pwd
bash setup.sh
wait
cd $WORK_DIR
wait
pwd
bash container_create.sh
wait
docker exec -it $CONTAINER '/usr/local/bin/check'
wait
