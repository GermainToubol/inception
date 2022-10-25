if [ ! -f "/var/www/blog/wp-config.php" ]; then
	wp core config                  \
       --dbname=wpdatabase          \
       --dbuser="${MDB_USER}"       \
       --dbpass="${MDB_PASSWD}"     \
       --dbhost=mariadb.mandatory   \
       --dbprefix=wp_               \
       --path="/var/www/blog" --allow-root

# 	# Install wordpress:
 	wp core install					\
 	   --url="gtoubol.42paris.fr"	\
 	   --title="Titre du Site"		\
 	   --admin_user="${WP_ADMIN}"	\
 	   --admin_password="${WP_ADMIN_PASS}"		\
 	   --admin_email="${WP_ADMIN_MAIL}"			\
 	   --path="/var/www/blog" --allow-root > /tmp/log2;
fi
chown -R www:www /var/www/blog

# Exec the main command (i.e. php_fpm8 -F)
exec $@
