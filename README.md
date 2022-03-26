# myscripts

Configuration files and usefull scrips.

## Linux - Linking configuration files

```bash
    ln -s ~/git-repos/myscripts/configs/nanorc ~/.nanorc
    ln -s ~/git-repos/myscripts/configs/tmux.conf ~/.tmux.conf
    ln -s ~/git-repos/myscripts/configs/spacemacs ~/.spacemacs

    ln -s ~/git-repos/myscripts/configs/aliases ~/.bash_aliases
    echo "source ~/git-repos/myscripts/configs/bash_utils" >> ~/.bashrc

    ln -s ~/git-repos/myscripts/configs/zshrc ~/.zshrc
```

### Windows Install

First add an environmental variable HOME pointing to your user folder (usually
under C:\Users\<YOURNAME>.

#### Enabling Hunspell for spell checking

Install Hunspell from chocolatey (choco install -y hunspell.portable) and add
dictionary files in C:\Hunspell. Finally, create 2 new Environmental variables
called DICT (en_US) and DICTPATH (C:\Hunspell)

#### Installing LaTeX

Download and install the TeX Live package. Give preference to at least the Medium
package collection if you don't have enough space for the full one.

#### Installing spacemacs

Clone spacemacs to your `.emacs.d` folder (prefer using git bash) and link your configuration file:

```cmd
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
    mklink ~/.spacemacs ~/git-repos\myscripts\configs\spacemacs-windows
```

