#!/bin/bash
set -x

echo "iptables Settings script turned in to the 'Prints a trace of commands' mode" && sleep 5

iptables-save > /etc/iptables_rules
chmod +x /etc/iptables_rules

echo "# copy /etc/iptables_rules to /root/iptables_rules_default" && sleep 2
cp /etc/iptables_rules /root/iptables_rules_default

echo "# ! Check just created /etc/iptables_rules" && sleep 2
ls /etc/ -lah | grep iptables_rules

echo "# Create iptables setup directly after NIC up" && sleep 5
echo "#!/bin/bash" > /etc/network/if-up.d/iptables
echo "iptables-restore < /etc/iptables_rules" >> /etc/network/if-up.d/iptables
echo "exit" >> /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables

echo "# ! Check /etc/network/if-up.d/iptables" && sleep 2
ls -lah /etc/network/if-up.d
cat /etc/network/if-up.d/iptables

set +x 

#TODO create a iptable pattern to use for very first iptables settings

exit
