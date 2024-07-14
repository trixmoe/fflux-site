#!/usr/bin/env bash
BRANCH=$1
EXPERIMENTAL="experimental"
AUTOUPDATER_VER=${2:-$EXPERIMENTAL}
if [ -z $BRANCH ]; then
	echo "Usage: freifunk_user.sh [branch] (updater_version)"
	echo ""
	echo "branch: gluon release branch"
	echo "updater_version: experimental, beta, stable. defaults to experimental"
	exit 1
fi
git clone ssh://kallithea@projects.c3l.lu/freifunk/Firmware-building
git clone https://github.com/freifunk-gluon/gluon.git gluon -b "$BRANCH"
ln -vs /home/user/Firmware-building/site_config/"${AUTOUPDATER_VER}"/site /home/user/gluon/site
pushd /home/user/gluon/
make update
popd

