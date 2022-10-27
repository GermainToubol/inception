#!/bin/sh

mysqld -u root --bind-address=localhost --silent-startup > /tmp/mariastart.log 2>&1 &
PID=$!
until tail "/tmp/mariastart.log" | grep -qi "Version:"; do
	sleep 0.2
done

<< EOF mysql
create database wpdatabase;
grant all privileges on wpdatabase.* to '${MDB_USER}'@wordpress.mandatory identified by '${MDB_PASSWD}';
alter user 'root'@'localhost' identified by '${MDB_ROOT_PASSWD}';
flush privileges;
EOF

kill -TERM ${PID}
chown -R mysql:mysql /var/lib/mysql;
exec $@
