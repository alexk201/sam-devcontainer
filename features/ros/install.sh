#!/usr/bin/env bash
set -e

# Map Ubuntu codenames to ROS distros (add future releases here)
declare -A ROS_MAP=(
    [jammy]="humble"
    [noble]="jazzy"
)

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

ARCH=$(dpkg --print-architecture)
CODENAME=$(. /etc/os-release && echo $UBUNTU_CODENAME)

if [ -z "$CODENAME" ]; then
    echo "Error: UBUNTU_CODENAME not found. Run on a supported Ubuntu system."
    exit 1
fi

ROS_DISTRO=${ROS_MAP[$CODENAME]}
if [ -z "$ROS_DISTRO" ]; then
    echo "Error: Unsupported Ubuntu codename '$CODENAME'. Supported: ${!ROS_MAP[@]}"
    exit 1
fi

# Add ROS repository key and source list
install -d -m 0755 /etc/apt/keyrings
wget -q https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -O /etc/apt/keyrings/ros.asc
echo "deb [arch=$ARCH signed-by=/etc/apt/keyrings/ros.asc] https://ftp.osuosl.org/pub/ros2 $CODENAME main" > /etc/apt/sources.list.d/ros.list

# Install ROS and essential tools
apt-get update && apt-get install -y --no-install-recommends \
    locales \
    ros-dev-tools \
    ros-$ROS_DISTRO-desktop \
    ros-$ROS_DISTRO-topic-tools \
    ros-$ROS_DISTRO-foxglove-bridge \
    ros-$ROS_DISTRO-diagnostic-updater \
    ros-$ROS_DISTRO-camera-calibration-parsers \
    python3-pip \
    python3-rosdep \
    python3-vcstool \
    python3-colcon-ros \
    python3-colcon-common-extensions

# Set environment variables for all users
echo "export ROS_INSTALL_PATH=/opt/ros/$ROS_DISTRO" >> /etc/bash.bashrc
echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /etc/bash.bashrc

# Generate and set recommended locales
locale-gen en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*