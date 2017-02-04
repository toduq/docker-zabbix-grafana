FROM ubuntu:xenial
MAINTAINER toduq <yuusuke12dec@gmail.com>

RUN \
  apt-get update && \
  apt-get install -y wget && \
  wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+xenial_all.deb && \
  dpkg -i zabbix-release_3.0-1+xenial_all.deb && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    mariadb-server \
    zabbix-server-mysql \
    zabbix-frontend-php \
    zabbix-agent \
    snmp \
    php-bcmath \
    php-mbstring \
    php-xml \
    monit && \
  rm -rf /var/lib/apt/lists/*

COPY start.sh migrate.sh /root/
COPY monitrc /etc/monitrc
COPY zabbix.conf.php /usr/share/zabbix/conf/zabbix.conf.php

RUN \
  chmod 600 /etc/monitrc && \
  sed -i -e 's/# php_value date\.timezone Europe\/Riga/php_value date\.timezone Asia\/Tokyo/g' /etc/apache2/conf-enabled/zabbix.conf

EXPOSE 80 2812 10050
CMD /root/start.sh
