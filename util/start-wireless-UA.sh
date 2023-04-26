#!/bin/bash

read -p "Username: " W_USERNAME
read -sp "Password: " W_PASSWD

echo "ctrl_interface=/var/run/wpa_supplicant
update_config=1
country=BE
network={
  ssid=\"UAntwerpen\"
  key_mgmt=WPA-EAP
  eap=PEAP
  identity=\"$W_USERNAME\"
  password=\"$W_PASSWD\"
  phase2=\"autheap=MSCHAPV2\"
}" > /tmp/wpa-supplicant.conf

sudo wpa_cli -i wlan0 terminate

sudo wpa_supplicant -B -i wlan0 -c /tmp/wpa-supplicant.conf
