#!/usr/bin/env bash

# https://www.tensorflow.org/install/source

set -eu

git fetch -atp && git checkout $TF_PACKAGE_VERSION

./configure

# https://www.tensorflow.org/install/source#expandable-1 (sample configuration session)
bazel build --config=opt \
    --config=noaws \
    --config=nogcp \
    --config=nohdfs \
    --config=nonccl \
    --jobs $BAZEL_JOBS \
    --verbose_failures \
    //tensorflow/tools/pip_package:build_pip_package

./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt

chown $HOST_PERMS /mnt/tensorflow-${TF_PACKAGE_VERSION#v}-*.whl