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

# OpenWrt Git references
FFRGB_BUILD_OPENWRT_GIT_URL=https://github.com/openwrt/openwrt.git
FFRGB_BUILD_OPENWRT_GIT_BRANCH=openwrt-22.03
FFRGB_BUILD_GLUON_DIRECTORY=openwrt

# Select gluon targets
FFRGB_BUILD_GLUON_TARGETS="ramips-mt7621"
FFRGB_BUILD_GLUON_DEVICES="d-link-dap-x1860-a1"
FFRGB_BUILD_GLUON_AUTOUPDATER_BRANCH=experimental

# Number of jobs used for make: Use number of processors
FFRGB_BUILD_JOB_COUNT=$(cat /proc/cpuinfo | grep processor | wc -l)

# Install required build packages
apt install build-essential gawk unzip libncurses-dev libz-dev libssl-dev wget git subversion

# Cleanup before build
rm -R -f ${FFRGB_BUILD_SITE_DIRECTORY}
rm -R -f ${FFRGB_BUILD_GLUON_DIRECTORY}

# Clone repositories
git clone ${FFRGB_BUILD_SITE_GIT_URL} -b ${FFRGB_BUILD_SITE_GIT_BRANCH} ${FFRGB_BUILD_SITE_DIRECTORY}
git clone ${FFRGB_BUILD_GLUON_GIT_URL} -b ${FFRGB_BUILD_GLUON_GIT_BRANCH} ${FFRGB_BUILD_GLUON_DIRECTORY}

# Apply Gluon patches
for patch in patches/gluon/*.patch; do
	git am --3way --ignore-space-change --keep-cr --directory=${FFRGB_BUILD_GLUON_DIRECTORY} "$patch"
done

ln -s $(realpath ${FFRGB_BUILD_SITE_DIRECTORY}) $(realpath ${FFRGB_BUILD_GLUON_DIRECTORY}/site)

make --directory=${FFRGB_BUILD_GLUON_DIRECTORY} update
for FFRGB_BUILD_GLUON_TARGET in ${FFRGB_BUILD_GLUON_TARGETS}; do
    echo Building ${FFRGB_BUILD_GLUON_TARGET}
    make --directory=${FFRGB_BUILD_GLUON_DIRECTORY} -j${FFRGB_BUILD_JOB_COUNT} GLUON_TARGET=${FFRGB_BUILD_GLUON_TARGET}
done

# Create images and move output folder to local directory
make --directory=${FFRGB_BUILD_GLUON_DIRECTORY} manifest GLUON_AUTOUPDATER_BRANCH=${FFRGB_BUILD_GLUON_AUTOUPDATER_BRANCH}
mv ${FFRGB_BUILD_GLUON_DIRECTORY}/output .

