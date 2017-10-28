#with ehternet cable
apt-get update
apt-get install firmware-brcm80211 pi-bluetooth wpasupplicant
#reboot
#editing your /etc/network/interfaces like this
-----------
auto lo
iface lo inte loopback

#auto eth0
#iface eth0 inet dhcp

allow-hotplug wlan0
iface wlan0 inet manual
wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface wlan0 inet dhcp
-----------
wpa_passphrase SSID passphrase > /etc/wpa_supplicant/wpa_supplicant.conf
-----------
#reboot
#in order to avoid boot crda warning
apt-get install iw crda wireless-regdb
#usefull command-line wireless tools
apt-get install wireless-tools
apt-get install wavemon
