#!/bin/bash

set -x

echo "Ethtool installation script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "install ethtool"
sleep 5
apt install ethtool

echo "Pick up one of the NIC"
ifconfig -a | grep -o '^[a-zA-Z0-9]*'

read -p "Enter NIC name to turn off rx and tx: " nic_name
echo "You entered $nic_name"
sleep 5
echo "set rx and tx checksumming OFF, so the NIC name is first in the list"
sleep 15
ethtool -K $nic_name tx off rx off

echo "check rx and tx checksumming with ethtool"
sleep 5
ethtool -k $nic_name | grep -E -- 'rx-checksumming|tx-checksumming'

echo "create and add ethtool2 config for if-up.d"
sleep 5
echo "#!/bin/bash" > /etc/network/if-up.d/ethtool2
echo "ethtool -K $nic_name tx off rx off" >> /etc/network/if-up.d/ethtool2 #TODO fix it
echo "exit" >> /etc/network/if-up.d/ethtool2

echo "check ethtool2 config if-up.d"
sleep 15
cat /etc/network/if-up.d/ethtool2

echo "make ethtool2 executable"
sleep 5
chmod +x /etc/network/if-up.d/ethtool2

set +x

exit
