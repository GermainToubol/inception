#!/bin/sh

adduser ${FTP_USER}
chpasswd <<EOF
${FTP_USER}:${FTP_PASSWD}
EOF

echo "${FTP_USER}" > /etc/vsftpd/vsftpd.chroot

exec $@
