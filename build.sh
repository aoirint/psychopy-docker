#!/bin/bash

docker build ./docker \
    -t aoirint/psychopy-docker \
    --build-arg BASE_IMAGE=nvidia/opengl:base-ubuntu18.04
