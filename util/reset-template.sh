#!/bin/bash
if [[ $UID -ne 0 ]]; then
    echo "Please run as root."
    exit 0
fi
apt update && apt dist-upgrade -y && \
apt autoremove -y && apt autoclean -y && apt clean -y && \
truncate -s 0 /etc/machine-id && \
shutdown -h now
