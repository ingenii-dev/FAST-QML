# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.238.0/containers/python-3/.devcontainer/base.Dockerfile

# [Choice] Python version (use -bullseye variants on local arm64/Apple Silicon): 3, 3.10, 3.9, 3.8, 3.7, 3.6, 3-bullseye, 3.10-bullseye, 3.9-bullseye, 3.8-bullseye, 3.7-bullseye, 3.6-bullseye, 3-buster, 3.10-buster, 3.9-buster, 3.8-buster, 3.7-buster, 3.6-buster
ARG VARIANT="3.10-bullseye"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="none"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

COPY requirements.txt /tmp/pip/
COPY installers /tmp/installers/
# Upgrade core OS and pip.
RUN apt update && export DEBIAN_FRONTEND=noninteractive && apt upgrade -y && pip3 install --upgrade pip
# If more packages needed add this line:
# && apt-get -y install --no-install-recommends <your-package-list-here>

# There are strict dependencies how to install the packages, and the requirements.txt file is in a
# specific order.
#
# Note: for local dev env we install CPU only PyTorch, for deployments we need to use a different
# requirements.txt which has CUDA extras. See: https://pytorch.org/get-started/locally/
RUN (for line in $(cat /tmp/pip/requirements.txt); do \
    sudo -u vscode pip3 --disable-pip-version-check --no-cache-dir install ${line}; \
    done) && rm -rf /tmp/pip-tmp

# Do the individual installers which have specific methods.
RUN sh /tmp/installers/chimera.sh && rm -rf /tmp/installers
