#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# add ros repository
wget -q https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -O /etc/apt/keyrings/ros.asc
echo "deb [signed-by=/etc/apt/keyrings/ros.asc] https://ftp.osuosl.org/pub/ros2 jammy main" > /etc/apt/sources.list.d/ros.list

# install required packages
apt-get update && apt-get install -y --no-install-recommends \
    locales \
    ros-humble-desktop \
    ros-humble-topic-tools \
    ros-humble-foxglove-bridge \
    ros-humble-diagnostic-updater \
    ros-humble-camera-calibration-parsers \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-ros \
    python3-colcon-common-extensions

# configure exports for interactive terminal
echo "source /opt/ros/humble/setup.bash" >> /etc/bash.bashrc

# configure recommended locales
locale-gen en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8