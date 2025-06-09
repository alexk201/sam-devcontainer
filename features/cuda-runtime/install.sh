#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# nvidia uses some special names for their system architectures...
NVIDIA_ARCH="$(arch | sed 's/aarch64/sbsa/g')"

# -------------------------------------------------------------
# CUDA 12.2 Setup Script for Broad GPU Compatibility (Ubuntu)
# -------------------------------------------------------------
# Notes:
# - The 'ubuntu2004' CUDA repository is used intentionally, even on newer Ubuntu versions (e.g., 24.04).
#   This is a stable and widely-compatible repository that works across multiple Ubuntu versions.
# - CUDA 12.2 is chosen for its proven compatibility with a broad range of NVIDIA GPUs,
#   from legacy Pascal GPUs (e.g., GTX 10xx series) to modern RTX 4000 series (used in AADC vehicles).
# - CUDA 12.2 is not available in the latest CUDA repos, so we use the older but compatible 20.04 repo.

wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVIDIA_ARCH}/3bf863cc.pub -O /etc/apt/keyrings/nvidia.asc
mkdir -p /etc/apt/keyrings
echo "deb [signed-by=/etc/apt/keyrings/nvidia.asc] https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/${NVIDIA_ARCH} /" > /etc/apt/sources.list.d/nvidia.list

apt-get update && apt-get install -y \
    cuda-cudart-12-2 \
    cuda-libraries-12-2 \
    libcudnn9-cuda-12

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*
