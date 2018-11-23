#!/bin/bash

# Get list of latest 100 mirrors and filter the best 10.

if [[ ! $USER -eq "root" ]]; then
    echo "Script must be run as root!"
    exit
fi

reflector --verbose --latest 100 --sort rate --save ./new_mirrors --protocol http --protocol https

rankmirrors -n 10 ./new_mirrors > /etc/pacman.d/mirrorlist
