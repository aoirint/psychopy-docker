ARG BASE_IMAGE=ubuntu:bionic
FROM $BASE_IMAGE

ARG PYTHON_VERSION=3.9.0
ARG PSYCHOPY_VERSION=2020.2.5

ARG PYTHON_ROOT=/usr/local
ARG PYENV_ROOT=/tmp/.pyenv
ARG PYBUILD_ROOT=/tmp/python-build

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y \
    # Python Install Dependencies
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    llvm \
    libncurses5-dev \
    libncursesw5-dev \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    python-openssl \
    git \
    # Psychopy Dependencies
    libhdf5-dev \
    freeglut3-dev \
    # General User Tools
    gosu \
  # Install Python
  && git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT \
  && PREFIX=$PYBUILD_ROOT $PYENV_ROOT/plugins/python-build/install.sh \
  && $PYBUILD_ROOT/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT \
  && rm -rf $PYBUILD_ROOT $PYENV_ROOT \
  # Install psychopy
  && pip3 install PsychoPy==$PSYCHOPY_VERSION

ADD ./docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
