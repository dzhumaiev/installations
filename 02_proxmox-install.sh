#!/bin/bash
set -x

echo "Proxmox installation script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "install proxmox-ve postfix open-iscsi chrony" && sleep 5
apt install proxmox-ve postfix open-iscsi chrony -y

echo "remove linux-image-amd64" && sleep 5
apt remove linux-image-amd64 'linux-image-6.1*' -y

echo "update-grub" && sleep 5
update-grub

echo "remove os-prober" && sleep 5
apt remove os-prober -y

echo "install ifupdown2" && sleep 5
apt-get install ifupdown2 -y

echo "list of /etc/apt/sources.list.d"
ls -lah /etc/apt/sources.list.d && sleep 5
echo "Backup or move pve-enterprise.list to avoid NON enterprise update failes"
mv /etc/apt/sources.list.d/pve-enterprise.list /root/pve-enterprise.list_bk
ls -lah /etc/apt/sources.list.d
ls -lah /root

echo "!!! reboot in 15 sec !!!" && sleep 15
systemctl reboot

set +x

exit
