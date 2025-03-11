#!/bin/bash

echo "!!! CHECK /etc/fail2ban/jail.local and /etc/fail2ban/filter.d/proxmox.conf BEFORE RUN THIS SCRIPT !!!"
sleep 10


# Add proxmox jail configuration to /etc/fail2ban/jail.local
echo "[proxmox]" >> /etc/fail2ban/jail.local
echo "enabled = true" >> /etc/fail2ban/jail.local
echo "port = https,http,8006" >> /etc/fail2ban/jail.local
echo "filter = proxmox" >> /etc/fail2ban/jail.local
echo "backend = systemd" >> /etc/fail2ban/jail.local
echo "maxretry = 3" >> /etc/fail2ban/jail.local
echo "findtime = 2d" >> /etc/fail2ban/jail.local
echo "bantime = 3h" >> /etc/fail2ban/jail.local

echo "jail.local proxmox part is:"
tail /etc/fail2ban/jail.local
sleep 10

# Create proxmox filter configuration
cat <<EOF > /etc/fail2ban/filter.d/proxmox.conf
[Definition]
failregex = pvedaemon\[.*authentication failure; rhost=<HOST> user=.* msg=.*
ignoreregex =
journalmatch = _SYSTEMD_UNIT=pvedaemon.service
EOF

echo "proxmox filter is:"
tail /etc/fail2ban/filter.d/proxmox.conf
sleep 10

# Restart fail2ban service
systemctl restart fail2ban

# Check fail2ban status
systemctl status fail2ban

# Wait for 5 seconds
sleep 5

# Check proxmox jail status
fail2ban-client status proxmox

echo "Fail2ban Proxmox configuration completed."