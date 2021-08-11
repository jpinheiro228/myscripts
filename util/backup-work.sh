#!/bin/bash

tar --exclude=.steam \
    --exclude=.local/share/Steam \
    --exclude=anaconda3 \
    --exclude=.virtualenvs \
    --exclude=Downloads/Xilinx \
    --exclude=Downloads/os \
    --exclude=Videos \
    --exclude=my-vms \
    --exclude='./VirtualBox VMs' \
    --exclude=.cache \
    --exclude=.arduino* \
    --exclude=bin \
    --exclude=.electron* \
    -vzpcf /run/user/1000/gvfs/smb-share:server=nas.local,share=home/`date +%4Y%2m`.tar.gz \
    -C /home/jpinheiro .
