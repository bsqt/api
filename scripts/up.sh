#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

export COMPOSE_PROJECT_NAME=bsqt_local

function cleanup() {
    docker-compose down
}
trap cleanup EXIT

docker-compose up -d

docker-compose logs -f api
