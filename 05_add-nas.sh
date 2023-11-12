#!/bin/bash
set -x

echo "NAS adding script turned in to the 'Prints a trace of commands' mode" && sleep 5

echo "# Add NAS for backups" && sleep 5
read -p "Enter NAS account name" NAS_account_name
read -p "Enter NAS account password" NAS_account_pwd
read -p "Enter NAS URL" NAS_url
pvesm add cifs $NAS_account_name --server $NAS_url --share $NAS_account_name --prune-backups keep-last=4 --content backup --username $NAS_account_name --password $NAS_account_pwd
pvesm status

set +x

exit

