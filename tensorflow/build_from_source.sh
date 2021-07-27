#!/usr/bin/env bash

set -u

git fetch -atp && git checkout $TF_PACKAGE_VERSION

./configure

bazel build --config=opt \
    # https://www.tensorflow.org/install/source#expandable-1 (sample configuration session)
    --config=noaws \
    --config=nogcp \
    --config=nohdfs \
    --config=nonccl \
    --jobs $BAZEL_JOBS \
    --verbose_failures \
    //tensorflow/tools/pip_package:build_pip_package

./bazel-bin/tensorflow/tools/pip_package/build_pip_package /mnt

chown $HOST_PERMS /mnt/tensorflow-${TENSORFLOW_VERSION#v}-*.whl