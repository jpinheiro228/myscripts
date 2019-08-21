#!/bin/bash

cd /tmp
sudo pacman -Syy --needed base-devel git
git clone https://aur.archlinux.org/pikaur.git
cd pikaur
makepkg -fsri
