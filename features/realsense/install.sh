#!/usr/bin/env bash
set -e

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

install -d -m 0755 /etc/apt/keyrings
wget -q https://librealsense.intel.com/Debian/librealsense.pgp -O /etc/apt/keyrings/librealsense.pgp
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" > /etc/apt/sources.list.d/librealsense.list

apt-get update && apt-get install -y --no-install-recommends \
    librealsense2-dev \
    librealsense2-dbg \
    librealsense2-utils

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*