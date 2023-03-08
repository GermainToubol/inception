# Inception
42 project with the aim to discover Docker and `docker compose` by building a website infrastructure.

## Mandatory
We had to build a wordpress website behind an Nginx webserver, and using mariadb.
Each service has it own docker.

## Usage
Mandatory part:
```bash
make
```

Bonus part
```bash
make bonus
```

## Bonus

As bonus I choosed to add:
 - redis cache to wordpress
 - adminer to consult the database
 - a small static website build with HUGO
 - a ftp server
 - a jupyterhub to create python notebooks
 
