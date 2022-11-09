#!/bin/sh

# Configure wordpress:
rm -f /var/www/blog/wp-config.php
wp core config                  \
   --dbname=wpdatabase          \
   --dbuser="${MDB_USER}"       \
   --dbpass="${MDB_PASSWD}"     \
   --dbhost=mariadb.mandatory   \
   --dbprefix=wp_               \
   --path="/var/www/blog";

# Install wordpress:
wp core install					\
   --url="gtoubol.42paris.fr"	\
   --title="Inception"			\
   --admin_user="${WP_ADMIN}"	\
   --admin_password="${WP_ADMIN_PASS}"		\
   --admin_email="${WP_ADMIN_MAIL}"			\
   --path="/var/www/blog";

# Add a new user:
wp user create "${WP_USER}" "${WP_USER_MAIL}"	\
   --role="author"								\
   --user_pass="${WP_USER_PASS}"				\
   --path="/var/www/blog";

# Change theme
if wp theme is-installed inspiro --path="/var/www/blog"; then :
else
	wp theme install inspiro\
	   --activate\
	   --path="/var/www/blog";

	wp plugin install elementor --activate --path="/var/www/blog";
	wp plugin install wpzoom-elementor-addons --activate --path="/var/www/blog";
	wp plugin install one-click-demo-import --activate --path="/var/www/blog";
	wp plugin install wpzoom-portfolio --activate --path="/var/www/blog";
fi

chown -R www-data:www-data /var/www/blog

echo "exec $@"
exec $@
