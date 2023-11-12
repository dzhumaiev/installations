#!/bin/sh
set -x

echo "iptables Settings script turned in to the 'Prints a trace of commands' mode" && sleep 5

iptables-save > /etc/iptables_rules
chmod +x /etc/iptables_rules

echo "#!/bin/sh" > /etc/network/if-pre-up.d/iptables
echo "iptables-restore < /etc/iptables_rules" >> /etc/network/if-pre-up.d/iptables
echo "exit" >> /etc/network/if-pre-up.d/iptables
chmod +x /etc/network/if-pre-up.d/iptables
ls -lah /etc/network/if-pre-up.d
cat /etc/network/if-pre-up.d/iptables

set +x 

exit