#!/usr/bin/env bash

set -eu

docker build -t arm-pip-tensorflow .

docker run -v $PWD/bin/:/mnt \
    -e HOST_PERMS="$(id -u):$(id -g)" \
    arm-pip-tensorflow
