if [[ ! -f "/var/www/blog/wp-config.php" ]]; then
	# Setup the wp-config: $1: MDB_USER $2: MDB_PASSWD
	wp core config					\
	   --dbname=wpdatabase			\
	   --dbuser="$1"				\
	   --dbpass="$2"				\
	   --dbhost=mariadb.mandatory	\
	   --dbprefix=wp_				\
	   --path="/var/www/blog";
	shift 2;

	# Install wordpress:
	#   $1: WP_ADMIN
	#   $2: WP_ADMIN_PASS
	#   $3: WP_ADMIN_MAIL
	wp core install					\
	   --url="gtoubol.42paris.fr"	\
	   --title="Titre du Site"		\
	   --admin_user="$1"			\
	   --admin_password="$2"		\
	   --admin_email="$3"			\
	   --path="/var/www/blog";
	shift 3;
else
	# Should skip all the entries thought for the wp setup
	shift 5;
fi

# Exec the rest of the arguments (i.e. php_fpm8 -F)
exec $@
