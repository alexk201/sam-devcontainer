#!/usr/bin/env bash

# configure bash defaults: exit on any failure
set -e

# check permissions
USERNAME="${USERNAME:-vscode}"

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

if [ ! id "$USERNAME" &>/dev/null ]; then
    echo -e "Error: Unprivileged user '$USERNAME' does not exist."
    echo -e "CARET cannot be installed as root. Please check and correct your 'remoteUser' setting in devcontainer.json."
    exit 1
fi

if [ ! -d /workspaces/caret_ws ]; then
  git clone https://github.com/tier4/caret.git /workspaces/caret_ws
  mkdir -p /workspaces/caret_ws/src
  chown -R vscode:vscode /workspaces/caret_ws
  cd /workspaces/caret_ws
  git switch -d "$VERSION"
fi

sudo -u "$USERNAME" bash user-install.sh