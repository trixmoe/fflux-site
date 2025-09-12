#!/usr/bin/env bash
set +xe

username=user
ssh_login_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOLFCOqpPOTZEQiWcY9TyVQnMoc5bCYlxLaRKhiB/uxo xbr 2024-06-16"
projects_c3l_pubkey="|1|X2M4bHKf8E+plhJ6KoDZzCfw5LI=|EpHLDWOmOq4SLelYTGd8SH+7hvU= ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIXfRmGmfbxPoErs5lpTnz+PZRQdh0QvPGTiswxFkXOx"

log() {
    printf "\033[33m[-] %s\033[0m\n" "$@"
}

install_packages() {
    log "Installing packages..."

    apt update && apt upgrade -y
    # Installing QoL packages (1) then gluon deps (2)
    # ! Debian 13-specific !
    apt install -y htop tmux vim sudo mosh \
                git python3 python-is-python3 python3-setuptools build-essential ecdsautils gawk unzip libncurses5-dev zlib1g-dev libssl-dev libelf-dev wget rsync time qemu-utils
}

create_user() {
    log "Creating user..."

    # user: forcing bash, and needs (passwordless) sudo
    useradd -ms /bin/bash -G sudo $username
    # enabling passwordless sudo
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g'
}

put_into_file() {
    file_path=$1
    permissions=$2
    owner=$3
    cat >> "$file_path"
    chmod -v "$permissions" "$file_path"
    chown "$owner" "$file_path"
}

ssh_setup() {
    log "Setting up SSH..."

    sudo -u user ssh-keygen -t ed25519 -N '' -C 'freifunk-builder' < /dev/zero

    home_dir=""; eval home_dir=~$username
    echo "$ssh_login_key" | put_into_file "$home_dir/.ssh/authorized_keys" 600 $username:$username
    echo "$projects_c3l_pubkey" | put_into_file "$home_dir/.ssh/known_hosts" 644 $username:$username

    echo
    log "The user's SSH pubkey is the following:"
    printf "\n\033[32;1m"
    cat "$home_dir/.ssh/id_ed25519.pub"
    printf "\033[0m\n"
    log "Do not forget to add it to projects.c3l.lu"
}

install_packages
create_user
ssh_setup
