#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# source os-relase information
. /etc/os-release

ADJUSTED_ARCH="$(arch | sed 's/aarch64/arm64/g')"
ADJUSTED_VERSION_ID="$(echo -n $VERSION_ID | tr -d ".")"

mkdir -p /etc/apt/keyrings
wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${ADJUSTED_VERSION_ID}/${ADJUSTED_ARCH}/3bf863cc.pub -O /etc/apt/keyrings/nvidia.asc
echo "deb [signed-by=/etc/apt/keyrings/nvidia.asc] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${ADJUSTED_VERSION_ID}/${ADJUSTED_ARCH} /" > /etc/apt/sources.list.d/nvidia.list
apt-get update && apt-get install -y --no-install-recommends \
    cuda-12-8 \
    cuda-libraries-dev-12-8 \
    libnvinfer-dev \
    libnvinfer-plugin-dev \
    libnvonnxparsers-dev
