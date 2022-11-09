---
title: "All about inception"
date: 2022-11-08T08:47:11+01:00
draft: false
---
# Project description

The aim of this project is to build an docker infrastructure able to run a
website and many realted services.

## Mandatory
### Description
At first level, we need to create 3 docker containers, each one running one of the following services:
   - `nginx`
   - `wordpress`
   - `mariadb`

Every container needs to be on the same `docker network` and `nginx` should be the
only access point through https (TLS>=1.2).

`mariadb` has it own volume carrying the database, where `nginx` and `wordpress`
share the files through a shared volume (allowing `nginx` to render directly any
static webpage and needing to question `wordpress` only when necessary).

### Nginx
First element you need is the webserver, ansering with the right protocol.
Thus, we configure the server to listen on port 443, using ssl TLS1.2 or TLS1.3,
with the right certificates (generated appart from the container and saved in
`docker secrets`). The specific configuration for the main domain is stored in a
serparated file and loaded from the main config file.

### Wordpress
Wordpress is installed at a relevent place in the document filesystem. Then I
used a bash script to setup the configuration, with all passwords and database
users, theme and so on.

### Mariadb
We are asked to use mariadb, which is quite strait forward to configure. Main
trick is to start the daemon in background first, setup the database and then
have it in foreground.

### Outside
Few tools are needed to complete this part:
	- openssl: to generate the keys and certificates
	- mariadb-client: to be able to do the sanity check of the container.
