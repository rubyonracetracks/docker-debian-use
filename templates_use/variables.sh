#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

ABBREV='<ABBREV>'
SUITE='<SUITE>'
OWNER='<OWNER>'
DISTRO='<DISTRO>'
DOCKER_IMAGE="ghcr.io/$OWNER/image-$DISTRO-$SUITE-$ABBREV"
CONTAINER="container-$DISTRO-$SUITE-$ABBREV"
