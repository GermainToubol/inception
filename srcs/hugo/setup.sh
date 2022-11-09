#!/bin/sh

if [ ! "$(ls -A /hugo/)" ]; then
	cd /hugo;
	hugo new site /hugo;
	git init
	git submodule add -f https://github.com/panr/hugo-theme-terminal.git themes/terminal
else
	echo "Website already initialized."
fi

if [ ! "$(ls -A /var/www/public)" ]; then
	echo "Create config file";
	cp /tmp/config.toml /hugo/config.toml;

	echo "Create posts"
	for file in $(ls /tmp/content); do
		hugo new "posts/${file}";
		cp "/tmp/content/${file}" "/hugo/content/posts/${file}"
	done

	echo "Generate website"
	cd /hugo && hugo;
	cp -r /hugo/public /var/www/
fi

exec "$@"
