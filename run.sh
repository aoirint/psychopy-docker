#!/bin/bash

docker run --rm -it \
    --gpus all \
    -e HOST_UID=$(id -u) \
    -e HOST_GID=$(id -g) \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    aoirint/psychopy-docker
