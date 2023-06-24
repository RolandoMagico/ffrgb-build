#!/bin/bash

################################################################################
# Configuration Section
################################################################################
# Freifunk Regensburg Git references
FFRGB_BUILD_SITE_GIT_URL=https://github.com/ffrgb/site-ffrgb.git
FFRGB_BUILD_SITE_GIT_BRANCH=v2022.x
FFRGB_BUILD_SITE_DIRECTORY=site-ffrgb

# Gluon Git references
FFRGB_BUILD_GLUON_GIT_URL=https://github.com/freifunk-gluon/gluon.git
FFRGB_BUILD_GLUON_GIT_BRANCH=v2022.1.x
FFRGB_BUILD_GLUON_DIRECTORY=gluon

# Select gluon targets
FFRGB_BUILD_GLUON_TARGETS=ramips-mt7621
FFRGB_BUILD_GLUON_DEVICES="d-link-dap-x1860-a1 dlink_covr-x1860-a1"

# Install required build packages
apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

# Cleanup before build
rm -R -f ${FFRGB_BUILD_SITE_DIRECTORY}
rm -R -f ${FFRGB_BUILD_GLUON_DIRECTORY}

# Clone repositories
git clone ${FFRGB_BUILD_SITE_GIT_URL} -b ${FFRGB_BUILD_SITE_GIT_BRANCH} ${FFRGB_BUILD_SITE_DIRECTORY}
git clone ${FFRGB_BUILD_GLUON_GIT_URL} -b ${FFRGB_BUILD_GLUON_GIT_BRANCH} ${FFRGB_BUILD_GLUON_DIRECTORY}

make --directory=${FFRGB_BUILD_GLUON_DIRECTORY} GLUON_TARGETS=${FFRGB_BUILD_GLUON_TARGETS} GLUON_DEVICES=${FFRGB_BUILD_GLUON_DEVICES} GLUON_SITEDIR=../${FFRGB_BUILD_SITE_DIRECTORY}
