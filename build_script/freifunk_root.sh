#!/usr/bin/env bash
# Installing QoL packages and then (after build-essential incl.) dependencies
apt update && apt install -y htop tmux vim sudo mosh build-essential git python3 python-is-python3 python3-distutils ecdsautils gawk unzip libncurses5-dev zlib1g-dev libssl-dev libelf-dev wget rsync time qemu-utils

# Create `user` user with `sudo` group
useradd -ms /bin/bash -G sudo user
# `sudo` group w/o password
sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g'

mkdir -v /home/user/.ssh
# my public key
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLFCOqpPOTZEQiWcY9TyVQnMoc5bCYlxLaRKhiB/uxo xbr 2024-06-16" >> /home/user/.ssh/authorized_keys
# projects.c3l.lu public key
echo "|1|X2M4bHKf8E+plhJ6KoDZzCfw5LI=|EpHLDWOmOq4SLelYTGd8SH+7hvU= ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXfRmGmfbxPoErs5lpTnz+PZRQdh0QvPGTiswxFkXOx" >> /home/user/.ssh/known_hosts
chown -vR user:user /home/user/.ssh
chmod -v 700 /home/user/.ssh
chmod -v 600 /home/user/.ssh/*
chmod -v 644 /home/user/.ssh/known_hosts
# make a key to have access to projects.c3l.lu
sudo -u user ssh-keygen -t ed25519 -N '' -C 'freifunk-hetzner-builder' -f /home/user/.ssh/id_ed25519 <<<n
echo ""
echo "The ssh key is the following: "
cat /home/user/.ssh/id_ed25519.pub
