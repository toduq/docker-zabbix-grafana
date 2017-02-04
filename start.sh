#!/bin/bash

if [ ! -d "/var/lib/grafana/plugins" ]; then
  echo "download grafana plugin"
  grafana-cli --pluginsDir /var/lib/grafana/plugins plugins install alexanderzobnin-zabbix-app
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
  echo "initialize mysql"
  mysql_install_db --datadir=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/zabbix" ]; then
  echo "migrate zabbix"
  /root/migrate.sh &
fi

/usr/bin/monit -d 10 -Ic /etc/monitrc
