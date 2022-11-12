adduser "${PY_ADMIN}"
adduser "${PY_USER}"

chpasswd <<EOF
${PY_ADMIN}:${PY_ADMIN_PASSWD}
${PY_USER}:${PY_USER_PASSWD}
EOF

exec "$@"
