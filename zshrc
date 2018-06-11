HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt extendedglob notify
unsetopt nomatch
bindkey -e

zstyle :compinstall filename '/home/jpinheiro/.zshrc'

autoload -Uz compinit
compinit

##############################################################
##################### Antigen Config #########################
source /home/jpinheiro/myapps/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).

antigen bundle git
antigen bundle archlinux
antigen bundle pip
antigen bundle command-not-found
antigen bundle cp
antigen bundle colored-man-pages

antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme bureau

# Tell Antigen that you're done.
antigen apply

##############################################################

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
