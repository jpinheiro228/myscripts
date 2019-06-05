#!/bin/bash

dd if=/dev/zero of=/loopbackfile.img bs=100M count=200

losetup -fP /loopbackfile.img

mkfs.ext4 /loopbackfile.img

mkdir /myGluster

mount -o loop /dev/loop0 /myGluster
