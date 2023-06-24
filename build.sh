#!/bin/bash

################################################################################
# Configuration Section
################################################################################
# Freifunk Regensburg Git references
FFRGB_GIT_URL=https://github.com/ffrgb/site-ffrgb.git
FFRGB_GIT_BRANCH=v2022.x

# Install required build packages
apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

# Clone repository
git clone ${FFRGB_GIT_URL} -b ${FFRGB_GIT_BRANCH}
cd site-ffrgb
