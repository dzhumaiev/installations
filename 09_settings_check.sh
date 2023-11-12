#!/bin/sh
set -x

echo "Settings check script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "Update files"
ls -lah /etc/apt/sources.list.d
ls -lah /root
sleep 20

fail2ban-client status sshd

pvesm status
sleep 20

cat /etc/network/interfaces
sleep 20

ls -lah /etc/network/if-up.d/

ifconfig -a | grep -o '^[a-zA-Z0-9]*'
read -p "Enter NIC name:" nic_name
ethtool -k $nic_name | grep -E -- 'rx-checksumming|tx-checksumming'

cat /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/conf/$nic_name/proxy_arp

ls -lah /etc | grep iptables
ls -lah /etc/network/if-pre-up.d


set +x

exit