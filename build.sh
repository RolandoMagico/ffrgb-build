#!/bin/bash

################################################################################
# Configuration Section
################################################################################
# Freifunk Regensburg Git references
FFRGB_BUILD_GIT_URL=https://github.com/ffrgb/site-ffrgb.git
FFRGB_BUILD_GIT_BRANCH=v2022.x

# Select gluon targets
FFRGB_BUILD_GLUON_TARGETS=ramips-mt7621

# Install required build packages
apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

# Clone repository
git clone ${FFRGB_BUILD_GIT_URL} -b ${FFRGB_BUILD_GIT_BRANCH}
cd site-ffrgb
make GLUON_TARGETS=${FFRGB_BUILD_GLUON_TARGETS}
