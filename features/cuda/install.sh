#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
mkdir -p /etc/apt/keyrings
wget -q https://nvidia.github.io/libnvidia-container/gpgkey -O /etc/apt/keyrings/nvidia.asc
echo "deb [signed-by=/etc/apt/keyrings/nvidia.asc] https://nvidia.github.io/libnvidia-container/stable/deb/$(arch | sed 's/aarch64/arm64/g') /" > /etc/apt/sources.list.d/nvidia.list
apt-get update && apt-get install -y --no-install-recommends nvidia-container-toolkit
