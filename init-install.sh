#!/bin/sh
# 
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
#
sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg
