#!/bin/sh

mysqld -u root --bind-address=localhost --silent-startup > /tmp/mariastart.log 2>&1 &
PID=$!
until tail "/tmp/mariastart.log" | grep -qi "Version:"; do
	sleep 0.2
done

mysql <<EOF
create database wpdatabase;
grant all privileges on wpdatabase.* to '${MDB_USER}'@wordpress.mandatory identified by '${MDB_PASSWD}';
alter user 'root'@'localhost' identified by '${MDB_ROOT_PASSWD}';
grant usage on wpdatabase.* to '${MDB_HEALTH}'@'localhost' identified by '${MDB_HEALTH_PASSWD}';
flush privileges;
EOF

mysql --password="${MDB_ROOT_PASSWD}" <<EOF
grant all privileges on wpdatabase.* to '${ADMINER_USER}'@adminer.mandatory identified by '${ADMINER_PASSWD}';
flush privileges;
EOF

kill -TERM ${PID}
chown -R mysql:mysql /var/lib/mysql;

exec $@
