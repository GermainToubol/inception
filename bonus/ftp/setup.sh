#!/bin/sh

adduser ${FTP_USER}
chpasswd <<EOF
${FTP_USER}:${FTP_PASSWD}
EOF

echo "${FTP_USER}" > /etc/vsftpd/vsftpd.chroot
mkdir -p "/home/${FTP_USER}/ftp"
chown -R "${FTP_USER}:${FTP_USER}" "/home/${FTP_USER}"

exec $@
