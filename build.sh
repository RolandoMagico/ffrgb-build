#!/bin/bash

################################################################################
# Configuration Section
################################################################################
# Freifunk Regensburg Git references
FFRGB_BUILD_GIT_URL=https://github.com/ffrgb/site-ffrgb.git
FFRGB_BUILD_GIT_BRANCH=v2022.x

# Select gluon targets
FFRGB_BUILD_GLUON_TARGETS=ramips-mt7621
FFRGB_BUILD_GLUON_DEVICES="d-link-dap-x1860-a1 dlink_covr-x1860-a1"

# Install required build packages
apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

# Clone repository
git clone ${FFRGB_BUILD_GIT_URL} -b ${FFRGB_BUILD_GIT_BRANCH}
cd site-ffrgb
make GLUON_TARGETS=${FFRGB_BUILD_GLUON_TARGETS} GLUON_DEVICES=${FFRGB_BUILD_GLUON_DEVICES}
