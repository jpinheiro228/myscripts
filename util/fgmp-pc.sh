#!/bin/bash

apt update && apt dist-upgrade -y && apt autoremove -y && \
apt install -y build-essential python3 python3-pip openssh-server \
               python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
               libgirepository1.0-dev gcc libcairo2-dev pkg-config python3-dev \
               git && \
pip3 install pycairo PyGObject

wget https://download-cf.jetbrains.com/python/pycharm-professional-2020.2.3.tar.gz && \
tar -xf pycharm-professional-2020.2.3.tar.gz && \
mv pycharm-2020.2.3 /opt/pycharm && \
chown -R 1000:1000 /opt/pycharm

sudo --user=#1000 /opt/pycharm/bin/pycharm.sh

echo ""
echo "##############################################################################################"
echo "################################# ATENCAO!!!!! ###############################################"
echo "##############################################################################################"
echo ""
echo "O Pycharm esta localizado em /opt/pycharm"
echo ""
echo "Para executar pela primeira vez, digite no terminal: /opt/pycharm/bin/pycharm.sh"
echo ""
echo "Utilize o menu de configuracao do Pycharm para criar um atalho (Configure>Create Desktop Entry)"

