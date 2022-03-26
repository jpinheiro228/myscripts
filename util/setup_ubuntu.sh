#!/bin/bash

sudo apt update && sudo apt dist-upgrade -y
sudo apt install -y tmux git build-essential nano cmake

if [[ ! -d ~/git-repos/myscripts ]]; then
    mkdir -p ~/git-repos
    git clone https://github.com/jpinheiro228/myscripts.git ~/git-repos/myscripts
elif [[ -d ~/git-repos/myscripts ]]; then
    cd ~/git-repos/myscripts && git pull
fi

ln -sf ~/git-repos/myscripts/configs/gitconfig ~/.gitconfig
ln -sf ~/git-repos/myscripts/configs/nanorc ~/.nanorc
ln -sf ~/git-repos/myscripts/configs/tmux.conf ~/.tmux.conf

MY_SHELL=`grep "^$USER" /etc/passwd |cut -d":" -f7`
if [[ $MY_SHELL = "/bin/bash" ]]; then
    if [[ -z $(cat ~/.bashrc|grep shell_utils) ]]; then
        echo "source ~/git-repos/myscripts/configs/shell_utils" >> ~/.bashrc
    fi
elif [[ $MY_SHELL = "/bin/zsh" ]]; then
    if [[ -z $(cat ~/.zshrc|grep shell_utils) ]]; then
        echo "source ~/git-repos/myscripts/configs/shell_utils" >> ~/.zshrc
    fi
fi
