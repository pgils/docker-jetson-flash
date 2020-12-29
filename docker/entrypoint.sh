#!/usr/bin/env bash

set -o errexit
set -o nounset
[ "${DEBUG:=false}" = true ] && set -o xtrace

# Update the 'size' property for the resin-root partitions
if [ -n "${ROOTFS_SIZE:-}" ]; then
    xmlstarlet ed --inplace -u \
        "/partition_layout/device/partition[starts-with(@name, 'resin-root')]/size" \
        -v "$ROOTFS_SIZE" \
        jetson-flash/assets/"$MACHINE"-assets/resinOS-flash.xml
fi

/jetson-flash/bin/cmd.js "$@"
