# installations
proxmox host VM installations and configs

# initially copy and past
```bash
cd /root && \
mkdir git_dzhumaiev && \
cd git_dzhumaiev && \
apt update && apt install git -y && \
git clone https://github.com/dzhumaiev/installations.git && \
cd installations && \
chmod +x *.sh && \
./01_init-install.sh
```
