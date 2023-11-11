#!/bin/bash

echo "# Add NAS for backups" && sleep 5
pvesm add cifs <NAS-account-name> --server <NAS-URL> --share <NAS-account-name> --prune-backups keep-last=2 --content backup --username <username> --password <password>
pvesm status

exit

