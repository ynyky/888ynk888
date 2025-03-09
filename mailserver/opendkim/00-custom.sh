#!/bin/bash
echo "Running custom initialization tasks..."
echo "*.*         /dev/stdout" > /etc/rsyslog.conf
echo "*.*         -/dev/stdout" > /etc/syslog.conf
echo "0.0.0.0/0" > /etc/opendkim/trusted.hosts
echo "mail._domainkey.example.com example.com:mail:/etc/opendkim/keys/example.com/mail.private" > /etc/opendkim/key.table
echo "*@example.com mail._domainkey.example.com" > /etc/opendkim/signing.table
mkdir -p /etc/opendkim/keys/example.com
cd /etc/opendkim/keys/example.com
opendkim-genkey -s mail -d example.com
chown opendkim:opendkim mail.private
chmod 600 mail.private

envsubst < /srv/opendkim.conf.env > /etc/opendkim.conf
# Place any custom initialization commands here.
# For example: set environment variables, adjust configurations, etc.

