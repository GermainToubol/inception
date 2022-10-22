#!/bin/sh

mysqld -u root --bind-address=localhost --silent-startup > /tmp/mariastart.log 2>&1 &
PID=$!
until tail "/tmp/mariastart.log" | grep -qi "Version:"; do
	sleep 0.2
done
echo -n "" > /tmp/setup_mysql.sql
echo "create database wpdatabase;" >> /tmp/setup_mysql.sql
echo "grant all privileges on wpdatabase.* to $1@wordpress.mandatory identified by '$2';" >> /tmp/setup_mysql.sql
echo "flush privileges;" >> /tmp/setup_mysql.sql
mysql < /tmp/setup_mysql.sql
kill -TERM ${PID}
