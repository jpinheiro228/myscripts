#!/bin/bash

# Get list of latest 50 Archlinux mirrors and select top 5.

if [[ ! $USER -eq "root" ]]; then
    echo "Script must be run as root!"
    exit
fi

reflector --verbose --fastest 50 --sort rate --save /tmp/new_mirrors

rankmirrors -n 5 /tmp/new_mirrors > /etc/pacman.d/mirrorlist

pacman -Syy
