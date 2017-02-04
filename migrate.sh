#!/bin/bash

while !(mysqladmin ping -s); do
  echo "waiting for mysql ..."
  sleep 2
done

echo "grant all privileges on zabbix.* to zabbix@localhost;" | mysql -uroot
echo "create database zabbix character set utf8 collate utf8_bin;" | mysql -uroot
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uroot zabbix

echo "migration done!"
exit 0
