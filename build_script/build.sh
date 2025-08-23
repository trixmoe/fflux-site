#!/usr/bin/env bash
USER_DIR=/home/user

GLUON_DIR=$USER_DIR/gluon
SITE_DIR=$USER_DIR/Firmware-building/site_config

EXPERIMENTAL_SITE=$SITE_DIR/experimental/site
BETA_SITE=$SITE_DIR/beta/site
STABLE_SITE=$SITE_DIR/stable/site

# $1: site directory
set_site_directory() {
    pushd $GLUON_DIR

    # if site file exists, remove it
    if [ -a site ]; then
        unlink site
    fi
    ln -s $1

    popd $GLUON_DIR
}

build() {
    pushd $GLUON_DIR

    for TARGET in $(make list-targets); do
        make -j16 GLUON_TARGET=$TARGET
    done

    popd
}

# $1: autoupdater branch
move_output_images() {
    pushd $GLUON_DIR

    mv output/images output-images-$1

    popd
}

#unset multiple env vars
unset BUILD_EXPERIMENTAL BUILD_BETA BUILD_STABLE

case $1 in
    exp)
        BUILD_EXPERIMENTAL=1
        ;;

    beta)
        BUILD_BETA=1
        ;;

    stable)
        BUILD_STABLE=1
        ;;

    all)
        BUILD_EXPERIMENTAL=1
        BUILD_BETA=1
        BUILD_STABLE=1
        ;;

    *)
        echo "fflux firmware building script"
        echo "Usage: build.sh <all|exp|beta|stable>"
        exit 1
        ;;
esac

pushd $GLUON_DIR

if [ -d $GLUON_DIR/output/images ]; then
    echo "Error: output images directory contains images. Please remove them before building."
    echo "Delete `gluon/output/images` directory and try again."
    exit 1
fi

set_site_directory() {
    echo "Linking $1"
}

build() {
    echo "Building images"
}

move_output_images() {
    echo "Moving output images to output-images-$1"
}

if [ -n "$BUILD_EXPERIMENTAL" ]; then
    set_site_directory $EXPERIMENTAL_SITE
    build
    move_output_images experimental
fi

if [ -n "$BUILD_BETA" ]; then
    set_site_directory $BETA_SITE
    build
    move_output_images beta
fi

if [ -n "$BUILD_STABLE" ]; then
    set_site_directory $STABLE_SITE
    build
    move_output_images stable
fi

popd