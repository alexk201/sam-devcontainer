#!/bin/sh
set -e

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

# Source the ros-env.sh to get ROS_DISTRO and setup bash
if [ -f /etc/profile.d/ros-env.sh ]; then
    source /etc/profile.d/ros-env.sh
fi

# Ensure ROS is installed and ROS_DISTRO is set
if [[ -z "${ROS_DISTRO:-}" ]]; then
    echo "Error: ROS is not detected. Please install ROS and ensure ROS_DISTRO is set." >&2
    exit 1
fi

apt-get update && apt-get install -y --no-install-recommends \
    ros-$ROS_DISTRO-realsense2-camera \
    ros-$ROS_DISTRO-realsense2-camera-msgs

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*