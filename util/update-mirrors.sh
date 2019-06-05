#!/bin/bash

# Get list of latest 100 mirrors and filter the best 10.

if [[ ! $USER -eq "root" ]]; then
    echo "Script must be run as root!"
    exit
fi

reflector --verbose --latest 50 --sort rate --save ./new_mirrors

rankmirrors -n 5 ./new_mirrors > /etc/pacman.d/mirrorlist

pacman -Syy
