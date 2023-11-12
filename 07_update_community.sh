#!/bin/sh

set -x

echo "Update community script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "list of /etc/apt/sources.list.d"
ls -lah /etc/apt/sources.list.d && sleep 5
echo "Backup or move pve-enterprise.list to avoid NON enterprise update failes"
mv /etc/apt/sources.list.d/pve-enterprise.list /root/pve-enterprise.list_bk
ls -lah /etc/apt/sources.list.d
ls -lah /root
set +x

exit