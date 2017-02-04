#!/bin/sh

docker run \
  -d \
  -p 80:80 \
  -p 3000:3000 \
  -p 10051:10051 \
  -v /var/lib/mysql \
  -v /var/lib/grafana \
  toduq/zabbix
