#!/usr/bin/env bash
set +xe

BRANCH=$1
EXPERIMENTAL="experimental"
AUTOUPDATER_VER=${2:-$EXPERIMENTAL}

if [ -z "$BRANCH" ]; then
	echo "Usage: freifunk_user.sh [gluon branch] (updater_version)"
	echo ""
	echo "branch: gluon release branch"
	echo "updater_version: experimental, beta, stable. defaults to experimental"
	echo ""
	echo "Example: ./freifunk_user.sh v2023.2.5 stable"
	exit 1
fi

git clone ssh://kallithea@projects.c3l.lu/freifunk/Firmware-building
git clone https://github.com/freifunk-gluon/gluon.git gluon -b "$BRANCH"
ln -vs ~/Firmware-building/site_config/"${AUTOUPDATER_VER}"/site ~/gluon/site

pushd ~/gluon/ || exit
make update
popd || exit

