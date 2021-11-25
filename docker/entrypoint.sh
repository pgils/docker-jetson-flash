#!/bin/bash

set -eu -o pipefail
[ "${DEBUG:=false}" = true ] && set -o xtrace

shopt -s extglob

prepare_image() {
    local image_input_file="$1"
    local image_path=/tmp/img
    local image_file=$image_path/balena-image.img
    local largest_file

    mkdir -p $image_path
    cd $image_path

    case "${image_input_file:-}" in
        # .tar, .tar.*, .tgz, .zip
        *.@(tar?(.*)|t?z?(?)|zip))
            bsdtar -xf "$image_input_file"
            # Assume the largest file is the image file
            largest_file=$(find . -type f -printf "%s %p\n" \
                | sort -nr | head -1 | cut -d' ' -f2)
            ln -s "$largest_file" "$image_file"
            ;;
        *.@(gz|bz2|xz|zst))
            bsdcat "$image_input_file" > "$image_file"
            ;;
        *)
            # Assume input file is a valid disk image
            ln -s "$image_input_file" "$image_file"
            ;;
    esac
    echo "$image_file"
}

# Update the 'size' property for the resin-root partitions
if [ -n "${ROOTFS_SIZE:-}" ]; then
    xmlstarlet ed --inplace -u \
        "/partition_layout/device/partition[starts-with(@name, 'resin-root')]/size" \
        -v "$ROOTFS_SIZE" \
        jetson-flash/assets/"$MACHINE"-assets/resinOS-flash.xml
fi

args=("$@")

# Replace the argument to --file option with an uncompressed/renamed version
for i in "${!args[@]}"; do
   if [[ "${args[$i]}" =~ -f|--file ]]; then
        old_image=${args[(($i+1))]}
        args[(($i+1))]=$(set -e; prepare_image "$old_image")
   fi
done

/jetson-flash/bin/cmd.js "${args[@]:-}"
