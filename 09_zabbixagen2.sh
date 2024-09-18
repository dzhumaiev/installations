#!/bin/bash
set -x

echo "Zabbix Agent 2 installation" && sleep 5

echo "Install Zabbix repository"
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-2+debian12_all.deb
dpkg -i zabbix-release_7.0-2+debian12_all.deb
apt update

echo "Install Zabbix agent2"
apt install zabbix-agent2 zabbix-agent2-plugin-* -y

echo "Start Zabbix agent2 process, press q to exit from the status mode"
systemctl restart zabbix-agent2
systemctl enable zabbix-agent2
systemctl status zabbix-agent2

set +x

exit
