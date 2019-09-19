#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Enable buildkit if possible
export DOCKER_BUILDKIT=1

# Image name
CI_REGISTRY_IMAGE=${CI_REGISTRY_IMAGE:-docker.candy.io/biscuit/api}
CI_COMMIT_SHA=${CI_COMMIT_SHA:-local}
CONTAINER_IMAGE_NAME="${CI_REGISTRY_IMAGE}:${CI_COMMIT_SHA}"

# Get commit message
CI_COMMIT_MESSAGE=${CI_COMMIT_MESSAGE:-}

# Build image
docker build \
  --build-arg COMMIT_HASH=CI_COMMIT_SHA \
  --build-arg COMMIT_MESSAGE=CI_COMMIT_MESSAGE \
  -t "${CONTAINER_IMAGE_NAME}" .
