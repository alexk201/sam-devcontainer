#!/bin/sh
set -e

# Ensure script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo 'Error: Run this script as root (sudo or USER root in Dockerfile).'
    exit 1
fi

install -d -m 0755 /etc/apt/keyrings
wget -q https://apt.llvm.org/llvm-snapshot.gpg.key -O /etc/apt/keyrings/llvm.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/llvm.asc] https://apt.llvm.org/$(lsb_release -cs) llvm-toolchain-$(lsb_release -cs)-20 main" > /etc/apt/sources.list.d/clangd.list


apt-get update && apt-get install -y --no-install-recommends clangd-20

# Cleanup
apt-get clean
rm -rf /var/lib/apt/lists/*