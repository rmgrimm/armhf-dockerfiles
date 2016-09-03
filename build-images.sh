#!/bin/bash

build_image() {
  local DOCKER_IMAGE

  . "$1/docker-image-info.sh"

  eval docker build --no-cache -t $DOCKER_IMAGE $1
}

BUILD_IMAGES=""

if [ "$#" -eq 0 ]; then
  for IMAGE in $(find . -mindepth 1 -maxdepth 1 -type d ! -iname .\* | sort)
  do
    BUILD_IMAGES="$BUILD_IMAGES'$IMAGE' "
  done
else
  for IMAGE in "$@"; do
    BUILD_IMAGES="$BUILD_IMAGES'$IMAGE' "
  done
fi

for IMAGE in $BUILD_IMAGES; do
  eval IMAGE=$IMAGE
  if [ ! -r "$IMAGE/docker-image-info.sh" ]; then
    echo "$IMAGE has no docker image information; skipping..."
    continue
  fi

  echo "Building docker image for $(basename $IMAGE)... " >&2

  build_image $IMAGE
done

unset BUILD_IMAGES
