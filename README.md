# myscripts

My configuration files for Emacs (Spacemacs), ZSH and a few usefull scrips.

## ZSH Shell

To enable ZSH configuration, make a link on your home folder:

```bash
    cd ~
    ln -s git-repos/myscripts/configs/zshrc .zshrc
```

## Spacemacs

To enable Spacemacs configuration, make a link on your home folder:

```bash
    cd ~
    ln -s git-repos/myscripts/configs/spacemacs .spacemacs
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
    cd ~
    git clone https://github.com/syl20bnr/spacemacs .emacs.d
    mklink .spacemacs git-repos\myscripts\configs\spacemacs-windows
```

