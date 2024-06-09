#!/usr/bin/env bash

export LC_ALL=C

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR/.. || exit

DOCKER_IMAGE=${DOCKER_IMAGE:-nudi/nudid-develop}
DOCKER_TAG=${DOCKER_TAG:-latest}

BUILD_DIR=${BUILD_DIR:-.}

rm docker/bin/*
mkdir docker/bin
cp $BUILD_DIR/src/nudid docker/bin/
cp $BUILD_DIR/src/nudi-cli docker/bin/
cp $BUILD_DIR/src/nudi-tx docker/bin/
strip docker/bin/nudid
strip docker/bin/nudi-cli
strip docker/bin/nudi-tx

docker build --pull -t $DOCKER_IMAGE:$DOCKER_TAG -f docker/Dockerfile docker
