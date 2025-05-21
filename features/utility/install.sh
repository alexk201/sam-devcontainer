#!/usr/bin/env bash
set -e

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /var/lib/apt/lists/*