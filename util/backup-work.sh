#!/bin/bash

DEST=/run/user/1000/gvfs/smb-share:server=nas.jpinheiro.tech,share=home/`date +%4Y%2m`.tar.gz
#DEST=/mnt/`date +%4Y%2m`.tar.gz

tar --exclude=.steam \
    --exclude=.local/share/Steam \
    --exclude=anaconda3 \
    --exclude=.virtualenvs \
    --exclude=Videos \
    --exclude=my-vms \
    --exclude='./VirtualBox VMs' \
    --exclude=.cache \
    --exclude=.arduino* \
    --exclude=bin \
    --exclude=.electron* \
    --exclude=.jd* \
    --exclude=.texlive* \
    --exclude=.node* \
    --exclude=.gem* \
    --exclude=.cert* \
    --exclude=.nv* \
    --exclude=.org.jabref* \
    --exclude=.conda* \
    --exclude=.python* \
    --exclude=.grsync* \
    -vzpcf $DEST \
    -C /home/jpinheiro .

exit 0
