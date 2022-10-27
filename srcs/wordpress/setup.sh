# Wait for mariadb
mariadb --user="${MDB_USER}" --password="${MDB_PASSWD}" -D wpdatabase -h mariadb.mandatory -e "show tables;"
while [ $? -ne 0 ]; do
	sleep 2;
	mariadb --user="${MDB_USER}" --password="${MDB_PASSWD}" -D wpdatabase -h mariadb.mandatory -e "show tables;"
done

if [ ! -f "/var/www/blog/wp-config.php" ]; then
	# Configure wordpress:
	wp core config                  \
       --dbname=wpdatabase          \
       --dbuser="${MDB_USER}"       \
       --dbpass="${MDB_PASSWD}"     \
       --dbhost=mariadb.mandatory   \
       --dbprefix=wp_               \
       --path="/var/www/blog" --allow-root > /tmp/config.log 2>&1;

 	# Install wordpress:
 	wp core install					\
 	   --url="gtoubol.42paris.fr"	\
 	   --title="Inception"			\
 	   --admin_user="${WP_ADMIN}"	\
 	   --admin_password="${WP_ADMIN_PASS}"		\
 	   --admin_email="${WP_ADMIN_MAIL}"			\
 	   --path="/var/www/blog" --allow-root > /tmp/init.log 2>&1;

	# Add a new user:
	wp user create "${WP_USER}" "${WP_USER_MAIL}"	\
	   --role="author"								\
	   --user_pass="${WP_USER_PASS}"				\
	   --path="/var/www/blog" --allow-root >> /tmp/init.log 2>&1;
fi
chown -R www-data:www-data /var/www/blog

# Exec the main command (i.e. php_fpm8 -F)
exec $@
