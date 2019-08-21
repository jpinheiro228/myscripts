#!/bin/bash

if [ $# -lt 2 ]
then

echo "No command line arguments provided (needed 2).

USAGE:
        sh $0 USERNAME HOSTNAME
"

exit 1
fi

USERNAME=$1
HOSTNAME=$2

echo "
###################################################
              TIME ZONE CONFIGURATION
###################################################
"
ln -sf /usr/share/zoneinfo/America/Fortaleza /etc/localtime

hwclock --systohc

echo "
###################################################
              LOCALE CONFIGURATION
###################################################
"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
#echo "pt_BR.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "
###################################################
             HOSTNAME CONFIGURATION
###################################################
"
echo "$HOSTNAME" > /etc/hostname

echo "127.0.0.1 localhost
::1 localhost
127.0.1.1 $HOSTNAME" > /etc/hosts

echo "
###################################################
               CREATING YOUR USER
###################################################
"

useradd -m -s /bin/zsh $USERNAME
#useradd -s /bin/zsh $USERNAME

groupadd sudo
usermod -aG sudo $USERNAME
echo "%sudo   ALL=(ALL) ALL" >> /etc/sudoers

echo "
###################################################
          ENTER YOUR USER'S PASSWORD
###################################################
"

passwd $USERNAME

echo "
###################################################
            ENTER THE ROOT PASSWORD
###################################################
"

passwd root

echo "
###################################################
        INSTALLING BASE SYSTEM WITH GNOME
###################################################
"

pacman -Syy base-devel openssh gnome thunderbird firefox git zsh bash-completion texlive-most emacs libgnome-keyring python-virtualenvwrapper grub efibootmgr os-prober intel-ucode cups cups-pdf hplip --needed --noconfirm

systemctl enable gdm
systemctl enable NetworkManager
systemctl enable org.cups.cupsd.service
#systemctl enable sshd

grub-install --bootloader-id=grub --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg
