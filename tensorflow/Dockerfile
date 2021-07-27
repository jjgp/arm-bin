# https://www.tensorflow.org/install/source

ARG UBUNTU_VERSION=latest

FROM arm64v8/ubuntu:${UBUNTU_VERSION}

ARG BAZELISK_VERSION=v1.10.1

# https://github.com/tensorflow/tensorflow/blob/a4dfb8d1a71385bd6d122e4f27f86dcebb96712d/configure.py
# these can be overriden with the docker run -e arguments
ENV BAZEL_JOBS=auto \
    CC_OPT_FLAGS=-Wno-sign-compare \
    LANG=C.UTF-8 \
    PYTHON_BIN_PATH=/usr/bin/python3 \
    TF_CUDA_CLANG=0 \
    TF_DOWNLOAD_CLANG=0 \
    TF_NEED_CUDA=0 \
    TF_NEED_ROCM=0 \
    TF_PACKAGE_VERSION=v2.5.0 \
    TF_SET_ANDROID_WORKSPACE=0 \
    USE_DEFAULT_PYTHON_LIB_PATH=1

RUN apt update && apt install -y \
    curl \
    git \
    python3-dev \
    python3-pip \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && pip install -U --user pip numpy wheel \
    && pip install -U --user keras_preprocessing --no-deps \
    && curl -sLo bazel https://github.com/bazelbuild/bazelisk/releases/download/${BAZELISK_VERSION}/bazelisk-linux-arm64 \
    && chmod +x bazel \
    && mv bazel /usr/local/bin \
    && git clone https://github.com/tensorflow/tensorflow.git

COPY build_from_source.sh .

WORKDIR /tensorflow

ENTRYPOINT ../build_from_source.sh
