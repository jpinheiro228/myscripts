#!/bin/bash

sudo apt update && sudo apt dist-upgrade -y

sudo apt install -y tmux git build-essential nano cmake

if [[ ! -d ~/git-repos/myscripts ]]; then
    mkdir -p ~/git-repos
    git clone https://github.com/jpinheiro228/myscripts.git
fi

ln -sf ~/git-repos/myscripts/configs/nanorc ~/.nanorc
ln -sf ~/git-repos/myscripts/configs/tmux.conf ~/.tmux.conf
ln -sf ~/git-repos/myscripts/configs/aliases ~/.bash_aliases

if [[ -z $(cat ~/.bashrc|grep bash_utils) ]]; then
    echo "source ~/git-repos/myscripts/configs/bash_utils" >> ~/.bashrc
fi
