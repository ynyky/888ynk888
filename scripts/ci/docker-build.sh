#!/bin/sh

set -ex

BASE_DIR=$(pwd)
IMAGES_DIR="./docker"

for d in $(ls -1 $IMAGES_DIR); do
    cd "$IMAGES_DIR/$d"

    TAG_LIST='-t '$CI_REGISTRY_IMAGE'/'$d':'$DOCKER_IMAGE_TAG''
    if [ ! -z "$DOCKER_IS_LATEST" ]
    then
        TAG_LIST=''$TAG_LIST' -t '$CI_REGISTRY_IMAGE'/'$d':latest'
    fi

    docker build --build-arg CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX=$CI_DEPENDENCY_PROXY_GROUP_IMAGE_PREFIX/ $TAG_LIST .
    docker push "$CI_REGISTRY_IMAGE/$d:$DOCKER_IMAGE_TAG"
    if [ ! -z "$DOCKER_IS_LATEST" ]
    then
        docker push "$CI_REGISTRY_IMAGE/$d:latest"
    fi

    cd $BASE_DIR
done
