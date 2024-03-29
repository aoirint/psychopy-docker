# syntax=docker/dockerfile:1.3-labs
ARG BASE_IMAGE=ubuntu:20.04
FROM $BASE_IMAGE

ARG PYTHON_VERSION=3.10.7
ARG PSYCHOPY_VERSION=2022.2.4

ARG PYTHON_ROOT=/usr/local
ARG PYENV_ROOT=/tmp/.pyenv
ARG PYBUILD_ROOT=/tmp/python-build

ARG DEBIAN_FRONTEND=noninteractive

RUN <<EOF
    set -eux
    apt-get update
    apt-get upgrade -y

    # Python Build Dependencies
    # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
    apt-get install -y \
        make \
        build-essential \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        wget \
        curl \
        llvm \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
        libxml2-dev \
        libxmlsec1-dev \
        libffi-dev \
        liblzma-dev \
        git

    # Psychopy Dependencies
    apt-get install -y \
        libhdf5-dev \
        freeglut3-dev \
        libwebkitgtk-1.0 \
        libusb-1.0-0-dev \
        portaudio19-dev \
        libasound2-dev \
        libsndfile1-dev \
        libportmidi-dev \
        liblo-dev

    # General User Tools
    apt-get install -y \
        gosu

    apt-get clean
    rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
    # Install Python
    set -eux
    git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    PREFIX=$PYBUILD_ROOT $PYENV_ROOT/plugins/python-build/install.sh
    $PYBUILD_ROOT/bin/python-build -v $PYTHON_VERSION $PYTHON_ROOT
    rm -rf $PYBUILD_ROOT $PYENV_ROOT
EOF

# Install wxPython (PsychoPy dependency)
# Linux wheel is not provided on PyPI, so we install it from wxPython website.
# https://www.psychopy.org/download.html#linux
ARG WXPYTHON_WHEEL_URL="https://extras.wxpython.org/wxPython4/extras/linux/gtk3/ubuntu-20.04/wxPython-4.2.0-cp310-cp310-linux_x86_64.whl"
RUN <<EOF
    set -eux
    mkdir -p /opt/wxpython
    cd /opt/wxpython
    wget "${WXPYTHON_WHEEL_URL}"
    pip3 install *.whl
    rm -rf /opt/wxpython
EOF

RUN <<EOF
    # Install psychopy
    set -eux
    pip3 install PsychoPy==$PSYCHOPY_VERSION
EOF

ADD ./docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
