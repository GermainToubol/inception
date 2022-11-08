# # Wait for mariadb
# mariadb --user="${MDB_USER}" --password="${MDB_PASSWD}" -D wpdatabase -h mariadb.mandatory -e "show tables;"
# while [ $? -ne 0 ]; do
# 	sleep 2;
# 	mariadb --user="${MDB_USER}" --password="${MDB_PASSWD}" -D wpdatabase -h mariadb.mandatory -e "show tables;"
# done

# Configure wordpress:
if [ ! -f "/var/www/blog/wp-config.php" ]; then
	wp core config                  \
       --dbname=wpdatabase          \
       --dbuser="${MDB_USER}"       \
       --dbpass="${MDB_PASSWD}"     \
       --dbhost=mariadb.mandatory   \
       --dbprefix=wp_               \
       --path="/var/www/blog";
fi

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

wp plugin install "redis-cache"\
   --activate\
   --path="/var/www/blog";

wp config set "WP_CACHE_KEY_SALT" "gtoubol.42paris.fr"\
   --path="/var/www/blog";
wp config set "WP_REDIS_HOST" "redis.mandatory"\
   --path="/var/www/blog";
wp config set "WP_REDIS_PASSWORD" ""\
   --path="/var/www/blog";
wp config set "WP_REDIS_TIMEOUT" 1 --raw\
   --path="/var/www/blog";
wp config set "WP_REDIS_READ_TIMEOUT" 1 --raw\
   --path="/var/www/blog";
wp config set "WP_REDIS_DATABASE" 0 --raw\
   --path="/var/www/blog";
wp redis enable --path="/var/www/blog";

chown -R www-data:www-data /var/www/blog

echo "exec $@"
exec $@
