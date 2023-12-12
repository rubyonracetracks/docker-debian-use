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
echo '1. If this resume.sh script does not work, then there is probably no'
echo 'container to resume.  You likely need to run the reset.sh script first.'
echo '2. If you are connected to two Docker containers from the same image '
echo 'simultaneously, changes in one container (outside of the shared folder) '
echo 'do not propagate to the other.  Use the join.sh script for multi-shell '
echo 'access to the same container.'
echo
bash container-start.sh
bash join.sh
