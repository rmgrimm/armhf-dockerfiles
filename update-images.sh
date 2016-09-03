#!/bin/bash

check_for_update() {
  local DOCKER_IMAGE
  local UPDATE_ENTRYPOINT
  local UPDATE_COMMAND

  . "$1/docker-image-info.sh"
  . "$1/update-check-info.sh"

  eval docker run --rm -it --entrypoint $UPDATE_ENTRYPOINT $DOCKER_IMAGE \
       $UPDATE_COMMAND
}

UPDATE_IMAGES=""
CHECK_IMAGES=""

if [ "$#" -eq 0 ]; then
  for IMAGE in $(find . -mindepth 1 -maxdepth 1 -type d ! -iname .\* | sort)
  do
    CHECK_IMAGES="$CHECK_IMAGES'$IMAGE' "
  done
else
  for IMAGE in "$@"; do
    CHECK_IMAGES="$CHECK_IMAGES'$IMAGE' "
  done
fi

for IMAGE in $CHECK_IMAGES; do
  eval IMAGE=$IMAGE
  if [ ! -r "$IMAGE/docker-image-info.sh" ]; then
    echo "$IMAGE has no docker image information; skipping..."
    continue
  fi

  if [ ! -r "$IMAGE/update-check-info.sh" ]; then
    echo "$IMAGE has no update information; skipping..."
    continue
  fi

  echo -n "Checking for updates for $(basename $IMAGE)... " >&2

  UPDATES_AVAILABLE=$(check_for_update $IMAGE)

  if [ $UPDATES_AVAILABLE -gt 0 ]; then
    echo "updates available." >&2
    UPDATE_IMAGES="$UPDATE_IMAGES'$IMAGE' "
  else
    echo "no updates found." >&2
  fi
done

unset CHECK_IMAGES

if [ -n "$UPDATE_IMAGES" ]; then
  eval exec ./build-images.sh $UPDATE_IMAGES
fi
