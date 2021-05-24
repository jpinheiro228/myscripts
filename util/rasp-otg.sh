#!/bin/bash

PI_BOOT=/run/media/jpinheiro/boot
PI_ROOTFS=/run/media/jpinheiro/rootfs

echo "This will enable USB OTG Mode on your Raspberry Pi with RASPBERRYPI OS."
echo "The pi will be accessible on pi@172.16.1.1"
echo "Do not forget to add a static IP to your computer on the interface that the Pi will create."

# Enable SSH
touch ${PI_BOOT}/ssh

# Add OTG
echo "dtoverlay=dwc2" > ${PI_BOOT}/config.txt
sed -i "s/rootwait/rootwait modules-load=dwc2,g_ether/" ${PI_BOOT}/cmdline.txt

# Configure OTG IP
echo "interface usb0
static ip_address=172.16.1.1/24" >> ${PI_ROOTFS}/etc/dhcpcd.conf

exit 0
