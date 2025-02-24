#!/bin/bash

sudo adduser sftp
sudo mkdir -p /var/sftp/uploads
sudo chown root:root /var/sftp
sudo chmod 755 /var/sftp
sudo chown sftp:sftp /var/sftp/uploads


cat << EOF | sudo tee -a /etc/ssh/sshd_config >> /dev/null
Match User sftp
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /var/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no
EOF

sudo systemctl restart sshd

echo "If everyting goes right, try connecting using\nsftp sftp@{server ip}"
