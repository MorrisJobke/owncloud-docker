#!/bin/bash
#
# This creates a ownCloud instance that is setup automatically by just linking
# a appropiate DB against the docker container. Currently only MySQL and PostgreSQL
# docker container are detected (called mysql and postgres on docker hub). If
# none is detect the ownCloud instance uses SQLite. There is also a patch included
# that speeds up ownCloud with SQLite.
#
# You can also set ADMINLOGIN, ADMINPWD and DATABASENAME as environment variables
# to adjust these data of the ownCloud instance.

if [ -z "$ADMINLOGIN" ]; then
	ADMINLOGIN=admin
fi
if [ -z "$ADMINPWD" ]; then
	ADMINPWD=admin
fi
if [ -z "$DATABASENAME" ]; then
	DATABASENAME=owncloud
fi

if [ -n "$DB_ENV_MYSQL_VERSION" ]; then
    echo "MySQL $DB_ENV_MYSQL_VERSION"
    DATABASEUSER=root
    DATABASEPWD=$DB_ENV_MYSQL_ROOT_PASSWORD
    DATABASE=mysql
    DBHOST=$DB_PORT_3306_TCP_ADDR
elif [ -n "$DB_ENV_PG_VERSION" ]; then
    echo "PostgreSQL $DB_ENV_PG_VERSION"
    DATABASEUSER=root
    DATABASEPWD=$DB_ENV_POSTGRES_PASSWORD
    DATABASE=postgres
    DBHOST=$DB_PORT_5432_TCP_ADDR
else
    echo "SQLite setup"
    DATABASEUSER=''
    DATABASEPWD=''
    DATABASE=sqlite
    DBHOST=''
fi

cat > /srv/www/htdocs/owncloud/config/autoconfig.php <<DELIM
<?php
\$AUTOCONFIG = array (
'installed' => false,
'dbtype' => '$DATABASE',
'dbtableprefix' => 'oc_',
'adminlogin' => '$ADMINLOGIN',
'adminpass' => '$ADMINPWD',
'dbuser' => '$DATABASEUSER',
'dbname' => '$DATABASENAME',
'directory' => '/srv/www/htdocs/owncloud/data',
'dbhost' => '$DBHOST',
'dbpass' => '$DATABASEPWD',
);
DELIM

cat /srv/www/htdocs/owncloud/config/autoconfig.php

echo "Setting up ownCloud ..."

cd /srv/www/htdocs/owncloud/ && php -f index.php | grep -i -C9999 error && echo "Error during setup" && exit 101

# fix wrong permission as this script is run as root and apache runs as wwwrun
chown -R wwwrun:www /srv/www/htdocs/owncloud

echo "Starting apache ..."

/usr/sbin/start_apache2 -D SYSTEMD -DFOREGROUND -k start
