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
echo "deb [signed-by=/etc/apt/keyrings/ros.asc] https://ftp.osuosl.org/pub/ros2 noble main" > /etc/apt/sources.list.d/ros.list

# install required packages
apt update && apt install -y --no-install-recommends \
    ros-jazzy-desktop \
    ros-jazzy-topic-tools \
    ros-jazzy-foxglove-bridge \
    ros-jazzy-diagnostic-updater \
    python3-colcon-ros

# configure exports for interactive terminal
echo "export ROS_INSTALL_PATH=/opt/ros/jazzy" >> /etc/bash.bashrc
echo "source /opt/ros/jazzy/setup.bash" >> /etc/bash.bashrc
