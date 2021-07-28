#!/usr/bin/env bash

set -eu

docker build -t arm-pip-tensorflow .

docker run -w /tensorflow \
    -v $PWD/build_from_source.sh:/build_from_source.sh \
    -v $PWD/bin/:/mnt \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    arm-pip-tensorflow \
    /bin/bash \
    /build_from_source.sh
