#!/bin/sh
#
set -x

echo "Fail2ban Proxmox installation script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "!!! install fail2ban" && sleep 5
apt install fail2ban -y
#
echo "!!! copy config file to local /etc/fail2ban/jail.conf -> jail.local" && sleep 5
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
#
echo "!!! create config file for sshd in the /etc/fail2ban/jail.d/" && sleep 5
cat >> /etc/fail2ban/jail.d/sshd.local << EOL
[sshd]
enabled = true
port = ssh
backend = systemd
logpath = %(sshd_log)s
maxretry = 2
bantime = 86400
EOL
#
echo "!!! make config executable" && sleep 5
chmod +x /etc/fail2ban/jail.d/sshd.local
#
echo "!!! status fail2ban service status" && sleep 5
systemctl status fail2ban
echo "!!! stop fail2ban service " && sleep 5
systemctl stop fail2ban
echo "!!! start fail2ban service " && sleep 5
systemctl start fail2ban
#echo "!!! enable fail2ban service " && sleep 5
#systemctl enabled fail2ban #because of Unknown command verb enabled.
echo "!!! status fail2ban service " && sleep 5
systemctl status fail2ban
#
echo "check fail2ban configs and activities" && sleep 5
fail2ban-client status
fail2ban-client status sshd
tail -F /var/log/fail2ban.log

set +x

exit
