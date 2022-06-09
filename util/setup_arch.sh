#!/bin/bash

sudo pacman -Syyu tmux git base-devel nano cmake

if [[ ! -d $HOME/git-repos/myscripts ]]; then
    mkdir -p $HOME/git-repos
    git clone https://github.com/jpinheiro228/myscripts.git $HOME/git-repos/myscripts
elif [[ -d $HOME/git-repos/myscripts ]]; then
    cd $HOME/git-repos/myscripts && git pull
fi

ln -sf $HOME/git-repos/myscripts/configs/gitconfig $HOME/.gitconfig
ln -sf $HOME/git-repos/myscripts/configs/nanorc $HOME/.nanorc
ln -sf $HOME/git-repos/myscripts/configs/tmux.conf $HOME/.tmux.conf

MY_SHELL=`grep "^$USER" /etc/passwd |cut -d":" -f7`
if [[ $MY_SHELL = "/bin/bash" ]]; then
    if [[ -z $(cat $HOME/.bashrc|grep shell_utils) ]]; then
        echo "source $HOME/git-repos/myscripts/configs/shell_utils" >> $HOME/.bashrc
    fi
elif [[ $MY_SHELL = "/bin/zsh" ]]; then
    if [[ -z $(cat $HOME/.zshrc|grep shell_utils) ]]; then
        echo "source $HOME/git-repos/myscripts/configs/shell_utils" >> $HOME/.zshrc
    fi
fi
