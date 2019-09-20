#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Image name
CI_REGISTRY_IMAGE=${CI_REGISTRY_IMAGE:-docker.candy.io/biscuit/api}
CI_COMMIT_SHA=${CI_COMMIT_SHA:-local}
CONTAINER_IMAGE_NAME="${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA}"

# Run application from image
docker run --rm "${CONTAINER_IMAGE_NAME}"
