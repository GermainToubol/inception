#!/bin/sh

hugo new site /var/www/public

exec "$@"
