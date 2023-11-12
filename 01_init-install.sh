#!/bin/sh
set -x

echo "Innitial installation script turned in to the 'Prints a trace of commands' mode" && sleep 5

# add comments and sleep
echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
# add comments and sleep
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
# add comments and sleep
sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
# add comments and sleep
apt update && apt full-upgrade -y
# add comments and sleep
apt install pve-kernel-6.2 -y
# add comments and sleep and input claryfication for reboot
echo "Going to reboot host in 20 sec"
sleep 20
systemctl reboot

set +x

exit