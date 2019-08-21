# Grub installation for EFI Boot

pacman -Syy linux grub efibootmgr --needed

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg
