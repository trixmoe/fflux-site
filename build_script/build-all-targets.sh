#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "cannot be run as root"
  exit
fi

# detect amount of CPU cores
CORES=$(lscpu|grep -e '^CPU(s):'|xargs|cut -d" " -f2)
#CORES=1

# build all regular targets
for TARGET in $(make list-targets); do
  make -j$CORES GLUON_TARGET=$TARGET GLUON_DEPRECATED=0 BROKEN=1 V=s
done

make -j$CORES GLUON_TARGET=brcm2708-bcm2710 GLUON_DEPRECATED=0 BROKEN=1 V=s
make -j$CORES GLUON_TARGET=ar71xx-mikrotik GLUON_DEPRECATED=0 BROKEN=1 V=s
