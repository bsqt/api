#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Image name
CI_REGISTRY_IMAGE=${CI_REGISTRY_IMAGE:-docker.bsqt.io/bsqt/api}
CI_COMMIT_SHA=${CI_COMMIT_SHA:-$(git rev-parse HEAD)}
export CONTAINER_IMAGE_NAME="${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA}"

# Run application from image
docker-compose up
