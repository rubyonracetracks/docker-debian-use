#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

bash container_create.sh
bash container_start.sh
source variables.sh
docker exec -d $CONTAINER 'bash shared/info.sh'
