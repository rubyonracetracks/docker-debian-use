#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

source variables.sh

echo 'Executing /usr/local/bin/check in Docker container'
docker exec "$CONTAINER" /usr/local/bin/check
