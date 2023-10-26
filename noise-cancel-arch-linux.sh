#!/bin/bash
# guide url https://medium.com/@gamunu/linux-noise-cancellation-b9f997f6764d

function install_dependencies {
    sudo pacman -S noise-suppression-for-voice
}

function create_structure {
    echo "  + Creating pipewire config directory"
    mkdir -p ${HOME}/.config/pipewire/
    echo "  + Created $(realpath .config/pipewire)"

    echo "  + Copying input-filter-chain.conf to .config/pipewire/"
    cp ./input-filter-chain.conf ${HOME}.config/pipewire/
    echo "  + Copied file to ${HOME}/.config/pipewire/"
}

function system_persist_config {
    echo "  + Creating system directory"
    mkdir -p ~/.config/systemd/user/
    echo "  + Created $(realpath .config/systemd/user/)"

    cp ./pipewire-input-filter-chain.service ${HOME}.config/systemd/user/
    echo "  + Copied file to ${HOME}/.config/systemd/user/"

    echo "  + Reloading daemon"
    systemctl --user daemon-reload

    echo "  + Enabling autostart and starting service now"
    systemctl --user {enable, start} pipewire-input-filter-chain.service
}


function service_status_check {
    echo "  + Checking service status"
    systemctl --user status pipewire-input-filter-chain.service
}

install_dependencies
create_structure
system_persist_config
service_status_check
