#!/bin/sh
# address 192.168.1.1/24 should be rechecked
# /proc/sys/net/ipv4/conf/<eno1>/proxy_arp - should be changed <eno1> on actual
echo "adding vmbr0 config"
sleep 5
cat >> /etc/network/interfaces << EOL
auto vmbr0
        iface vmbr0 inet static
        address 192.168.1.1/24
        bridge-ports none
        bridge-stp off
        bridge-fd 0

        post-up echo 1 > /proc/sys/net/ipv4/ip_forward
        post-up echo 1 > /proc/sys/net/ipv4/conf/eno1/proxy_arp
EOL

echo "check the content in the /etc/network/interfaces"
sleep 5
cat /etc/network/interfaces

echo "start the vmbr0"
sleep 10
ifup vmbr0

echo "get interfaces names"
sleep 10
ifconfig -a | grep -o '^[a-zA-Z0-9]*'
# ethtool -K $(ifconfig -a | head -n 1 | grep -o '^[a-zA-Z0-9]*') tx off rx off - if the using NIC is a first
# TODO add NIC UP status checking
echo "install ethtool"
sleep 5
apt install ethtool

echo "check rx and tx checksumming with ethtool"
sleep 5
# ethtool -K $(ifconfig -a | head -n 1 | grep -o '^[a-zA-Z0-9]*') tx off rx off - if the using NIC is a first
ethtool -k enp5s0 | grep -E -- 'rx-checksumming|tx-checksumming'

echo "turn off rx and tx checksumming with ethtool"
sleep 5
ethtool -K enp5s0 tx off rx off

echo "check rx and tx checksumming with ethtool"
sleep 5
ethtool -k enp5s0 | grep -E -- 'rx-checksumming|tx-checksumming'

echo "create and add ethtool2 config for if-up.d"
sleep 5
cat >> /etc/network/if-up.d/ethtool2 << EOL
#!/bin/sh

ethtool -K enp5s0 tx off rx off

exit
EOL

echo "make ethtool2 executable"
sleep 5
chmod +x /etc/network/if-up.d/ethtool2

echo "check ethtool2 config if-up.d"
sleep 5
cat /etc/network/if-up.d/ethtool2

exit