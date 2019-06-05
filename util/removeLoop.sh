#!/bin/bash

umount /myGluster

rm -r /myGluster

losetup -d /dev/loop0

rm /loopbackfile.img
