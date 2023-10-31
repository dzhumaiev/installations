#!/bin/bash

# !!! did not test !!! it need to troubleshoot

# Check if the script is run as root (or with sudo)
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or using sudo."
  exit 1
fi

# List available storage devices
lsblk

# Prompt the user to select an SSD device
read -p "Enter the SSD device (e.g., /dev/sdX): " ssd_device

# Create a GPT partition table on the selected device
fdisk $ssd_device <<EOF
g
w
EOF

# Create a single partition that spans the entire disk
fdisk $ssd_device <<EOF
n
1

w
EOF

# Format the partition as ext4
mkfs.ext4 ${ssd_device}1

# Mount the partition temporarily
mount ${ssd_device}1 /mnt

# Generate a UUID for the partition
uuid=$(blkid -o value -s UUID ${ssd_device}1)

# Add an entry to /etc/fstab
echo "UUID=$uuid /mnt ext4 defaults 0 0" >> /etc/fstab

# Mount the partition from /etc/fstab
mount -a

# Inform the user about the successful setup
echo "SSD storage device is now formatted with ext4, added to /etc/fstab, and mounted at /mnt."
#
