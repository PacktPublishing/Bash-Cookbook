#!/bin/sh
## usage:
## sudo ./wpa2-wifi-connect.sh <ssid> <pass>
ifdown wlan0
# build the interfaces file that will point to the file that holds our configuration
rm /etc/network/interfaces
touch /etc/network/interfaces
echo 'auto lo' >> /etc/network/interfaces
echo 'iface lo inet loopback' >> /etc/network/interfaces
echo 'iface eth0 inet dhcp' >> /etc/network/interfaces
echo 'allow-hotplug wlan0' >> /etc/network/interfaces
echo 'iface wlan0 inet manual' >> /etc/network/interfaces
echo 'wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf' >> /etc/network/interfaces
echo 'iface default inet dhcp' >> /etc/network/interfaces
# build the supplicant file that holds our configuration
rm /etc/wpa_supplicant/wpa_supplicant.conf
touch /etc/wpa_supplicant/wpa_supplicant.conf
echo 'ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'update_config=1' >> /etc/wpa_supplicant/wpa_supplicant.conf
wpa_passphrase $1 $2 >> /etc/wpa_supplicant/wpa_supplicant.conf
ifup wlan0
