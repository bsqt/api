#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Read env file
if [[ -f .env ]]; then
    source .env
fi

# Get git info
COMMIT_HASH=${CI_COMMIT_SHA:-$(git rev-parse HEAD)}
COMMIT_MESSAGE=${CI_COMMIT_MESSAGE:-$(git show -s --format=%B)}

# Check if name set
CONTAINER_IMAGE_NAME="${CONTAINER_IMAGE_NAME:?CONTAINER_IMAGE_NAME is required}"

# Build
export DOCKER_BUILDKIT=1

docker build \
  --build-arg COMMIT_HASH="${COMMIT_HASH}" \
  --build-arg COMMIT_MESSAGE="${COMMIT_MESSAGE}" \
  -t "${CONTAINER_IMAGE_NAME}" .
