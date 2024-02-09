#!/bin/sh
set -x

echo "Network innitial setip script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "adding vmbr0 config"
sleep 5
read -p "# Enter network GW (like 192.168.1.1), if migration then see IP on the source host: " ip_gw

# add configs to the >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto vmbr0" >> /etc/network/interfaces
echo "        iface vmbr0 inet static" >> /etc/network/interfaces
echo "        address $ip_gw/24" >> /etc/network/interfaces
echo "        bridge-ports none" >> /etc/network/interfaces
echo "        bridge-stp off" >> /etc/network/interfaces
echo "        bridge-fd 0" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "        post-up echo 1 > /proc/sys/net/ipv4/ip_forward" >> /etc/network/interfaces
echo "use one of these interface name for proxy_arp"
ifconfig -a | grep -o '^[a-zA-Z0-9]*'
sleep 5

read -p "Enter NIC name:" nic_name
echo "        post-up echo 1 > /proc/sys/net/ipv4/conf/$nic_name/proxy_arp" >> /etc/network/interfaces #TODO fix it

echo "check the content in the /etc/network/interfaces"
sleep 5
cat /etc/network/interfaces

echo "start the vmbr0"
sleep 10
ifup vmbr0

echo "check ip all"
ip a
sleep 10

echo "check ip_foreard is 1st and proxy_arp is 2nd"
cat /proc/sys/net/ipv4/ip_forward
cat /proc/sys/net/ipv4/conf/$nic_name/proxy_arp
sleep 10

set +x

exit
