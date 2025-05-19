#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

mkdir -p /etc/apt/keyrings
wget -q https://librealsense.intel.com/Debian/librealsense.pgp -O /etc/apt/keyrings/librealsense.pgp
echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo jammy main" > /etc/apt/sources.list.d/librealsense.list
apt-get update && apt-get install -y --no-install-recommends \
    librealsense2-dev \
    librealsense2-dkms \
    librealsense2-utils \
    librealsense2-dbg
