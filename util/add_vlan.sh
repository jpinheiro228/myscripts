#!/bin/bash

sudo ip link add link enp2s0 name vlan1 type vlan id 1
sudo ip link add link enp2s0 name vlan2 type vlan id 2
sudo ip link add link enp2s0 name vlan3 type vlan id 3
sudo ip link add link enp2s0 name vlan4 type vlan id 4
sudo ip link add link enp2s0 name vlan5 type vlan id 5
sudo ip link add link enp2s0 name vlan6 type vlan id 6
