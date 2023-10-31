#!/bin/sh
# TODO add comments
echo "install proxmox-ve postfix open-iscsi chrony" && sleep 5
apt install proxmox-ve postfix open-iscsi chrony -y
# TODO add comments
echo "remove linux-image-amd64" && sleep 5
apt remove linux-image-amd64 'linux-image-6.1*' -y
# TODO add comments
echo "update-grub" && sleep 5
update-grub
# TODO add comments
echo "remove os-prober" && sleep 5
apt remove os-prober -y
# TODO add comments
echo "install ifupdown2" && sleep 5
apt-get install ifupdown2 -y
# TODO add comments
echo "!!! reboot !!!" && sleep 15
systemctl reboot