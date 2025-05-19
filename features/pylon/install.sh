#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

mkdir -p /etc/apt/keyrings
cat >/etc/apt/keyrings/ros.asc <<EOL
-----BEGIN PGP PUBLIC KEY BLOCK-----

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
2XiBYfBQ6vo7Da8RRALWxjJM7g==
=dKt9
-----END PGP PUBLIC KEY BLOCK-----
EOL

echo "deb [signed-by=/etc/apt/keyrings/ros.asc] https://nexus.apps.code-forge.eu/repository/apt-baslerweb jammy main" > /etc/apt/sources.list.d/ros.list
apt-get update && apt-get install -y --no-install-recommends pylon
