#!/bin/bash

# !!! did not test !!! it need to troubleshoot

echo "# Check if the script is run as root (or with sudo)" && sleep 5
if [ "$EUID" -ne 0 ]; then
  echo "# Please run this script as root or using sudo."
  exit 1
fi

echo "# List available storage devices" && sleep 5
lsblk
echo "#  Prompt the user to select an SSD device" && sleep 5
read -p "# Enter the SSD device (e.g., /dev/sdX): " ssd_device

echo "# Create a GPT partition table on the selected device" && sleep 5
fdisk $ssd_device <<EOF
g
w
EOF

echo "# Create a single partition that spans the entire disk" && sleep 5
fdisk $ssd_device <<EOF
n
1

w
EOF

echo "# Format the partition as ext4" && sleep 5
mkfs.ext4 ${ssd_device}1

read -p "# Enter the mount point ssd02 for device (like /mnt/ssd02): " mount_point

echo "# Create mount point $mount_point" && sleep 5
mkdir $mount_point
ls $mount_point -lah

echo "# Mount the partition temporarily" && sleep 5
mount ${ssd_device}1 $mount_point
lsblk

echo "# Generate a UUID for the partition" && sleep 5
uuid=$(blkid -o value -s UUID ${ssd_device}1)

echo "# Add an entry to /etc/fstab" && sleep 5
echo "UUID=$uuid $mount_point ext4 defaults 0 0" >> /etc/fstab

echo "# Mount the partition from /etc/fstab" && sleep 5
mount -a

echo "# SSD storage device $ssd_device is now formatted with ext4, added to /etc/fstab, and mounted at $mount_point" && sleep 5
lsblk

exit

