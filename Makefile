.PHONY: build
build:
	docker build ./docker \
		-t aoirint/psychopy-docker \
		--build-arg BASE_IMAGE=nvidia/opengl:base-ubuntu20.04

.PHONY: run
run:
	docker run --rm -it \
		--gpus all \
		-e HOST_UID=$(id -u) \
		-e HOST_GID=$(id -g) \
		-e DISPLAY \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		aoirint/psychopy-docker

