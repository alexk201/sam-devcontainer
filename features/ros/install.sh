#!/bin/sh
set -e

ROS_DISTRO=${DISTRO}

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

# Add ROS repository key and source list
install -d -m 0755 /etc/apt/keyrings
wget -q https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -O /etc/apt/keyrings/ros.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/ros.asc] https://ftp.osuosl.org/pub/ros2 $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros.list

# Install ROS and essential tools
apt-get update && apt-get install -y --no-install-recommends \
    locales \
    ros-dev-tools \
    ros-$ROS_DISTRO-desktop \
    ros-$ROS_DISTRO-topic-tools \
    ros-$ROS_DISTRO-foxglove-bridge \
    ros-$ROS_DISTRO-diagnostic-updater \
    ros-$ROS_DISTRO-ament-clang-format \
    ros-$ROS_DISTRO-camera-calibration-parsers \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-ros \
    python3-colcon-common-extensions

# Set environment variables for all shells
cat << EOF > /etc/profile.d/ros-env.sh
export ROS_INSTALL_PATH=/opt/ros/$ROS_DISTRO
source /opt/ros/$ROS_DISTRO/setup.bash
EOF

# Generate and set recommended locales
locale-gen en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*