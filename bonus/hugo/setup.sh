#!/bin/sh

if [ ! "$(ls -A /hugo/)" ]; then
	cd /hugo;
	hugo new site /hugo;
	git init
	git submodule add -f https://github.com/panr/hugo-theme-terminal.git themes/terminal
else
	echo "Website already initialized."
fi

if [ 1 "$(ls -A /var/www/public)" ]; then
	echo "Create config file";
	cat <<EOF > /hugo/config.toml;
baseURL = "https://static.gtoubol.42paris.fr/"
buildDrafts = true # To allow configuration
defaultContentLanguage = "en"
title = "Inception showcase"
theme = "terminal"

[Params]
	mainSections = ["post"]
	intro = true
	headline = "my headline"
	description = "an amazing description"
	github = "https://githun.com/GermainToubol"
	email = "germain.toubol.pro@gmail.com"
EOF

	hugo new posts/all-about-inception.md;
	cat <<EOF > /hugo/content/posts/all-about-inception.md;
---
title: "All about inception"
date: 2022-11-08T08:47:11+01:00
draft: false
---
# Project description

The aim of this project is to build an docker infrastructure able to run a
website and many realted services.

## Mandatory

At first level, we need to create 3 docker containers, each one running one of the following services:
   - nginx
   - wordpress
   - mariadb

EOF

	cd /hugo && hugo;
	cp -r /hugo/public /var/www/
fi

exec "$@"
