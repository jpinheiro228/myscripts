### Setting up Pi Zero OTG (No USB keyboard, mouse or HDMI monitor needed)

On the Raspberry Pi 4, the USB-C connector is OTG ready, meaning that you can
simply connect your PC using a USB-C to USB-(C or A) cable to your Raspberry Pi
and access it over SSH

#### RaspberryPi OS

1. Flash you SD car with the latest RaspberryPi OS
   ([Link](https://www.raspberrypi.org/software/))

2. Once flashed, open up the BOOT PARTITION and add to the bottom of the
`config.txt` file `dtoverlay=dwc2` on a new line, then save the file.

3. Enable SSH by creating a file called `ssh` on the BOOT PARTITION

4. Finally, open up the `cmdline.txt` and insert `modules-load=dwc2,g_ether`
right after `rootwait`.

5. To make sure you can access your Pi, add an static IP to it. Open the ROOTFS
   PARTITION and add to the bottom of the `/etc/dhcpcd.conf` the following
   lines:

```text
interface usb0
static ip_address=172.16.1.1/24
```

6. Turn on your Pi by connecting it to your computer and then access it with
`ssh pi@172.16.1.1`

#### Ubuntu Server

1. Flash you SD car with the latest Ubuntu Server
   ([Link](https://ubuntu.com/download/raspberry-pi))

2. Once flashed, open up the BOOT PARTITION and add to the bottom of the
`nobtconfig.txt` file `dtoverlay=dwc2` on a new line, then save the file.

3. Enable SSH by creating a file called ``ssh`` on the BOOT PARTITION

4. Finally, open up the `nobtcmdline.txt` and insert `modules-load=dwc2,g_ether`
right after `rootwait`.

5. To make sure you can access your Pi, add an static IP to it. Still on the
   BOOT PARTITION, add the following right after the `eth0` configuration:

```text
usb0:
  dhcp4: false
  addresses:
    - 172.16.1.1/24
  optional: true
```

6. Turn on your Pi by connecting it to your computer and then access it with
   `ssh ubuntu@172.16.1.1`
