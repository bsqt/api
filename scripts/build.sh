#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Get git info
COMMIT_HASH=${CI_COMMIT_SHA:-$(git rev-parse HEAD)}
COMMIT_MESSAGE=${CI_COMMIT_MESSAGE:-$(git show -s --format=%B)}

# Image name
IMAGE_REPO="docker.bsqt.io/bsqt/api"
IMAGE_TAG="${COMMIT_HASH}"

IMAGE_NAME="${IMAGE_REPO}:${IMAGE_TAG}"

# Build
export DOCKER_BUILDKIT=1

docker build \
  --build-arg COMMIT_HASH="${COMMIT_HASH}" \
  --build-arg COMMIT_MESSAGE="${COMMIT_MESSAGE}" \
  -t "${IMAGE_NAME}" .
