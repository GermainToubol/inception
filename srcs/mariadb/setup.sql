create database wpdatabase;
grant all privileges on wpdatabase.* to wpuser@wordpress.mandatory identified by $WP_PASSWD;
flush privileges;
