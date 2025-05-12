#!/bin/bash
mkdir nextcloud
cd nextcloud
cat << EOF > .env
MYSQL_ROOT_PASSWORD=root
MYSQL_USER=nextcloud
MYSQL_PASSWORD=nextcloud
MYSQL_DATABASE=nextcloud
MYSQL_HOST=db
REDIS_HOST=redis
OVERWRITEPROTOCOL=https
TRUSTED_PROXIES=caddy
APACHE_DISABLE_REWRITE_IP=1
OVERWRITEHOST=nextcloud.example.com
EOF
docker network create nextcloud_network
