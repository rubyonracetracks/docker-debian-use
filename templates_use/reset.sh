#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

source variables.sh

wget -O - https://gitlab.com/rubyonracetracks/docker-common/raw/main/delete-containers.sh | bash -s "$CONTAINER"

bash container-create.sh
bash container-start.sh
bash join.sh
