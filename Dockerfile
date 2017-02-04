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
    adduser \
    libfontconfig \
    monit && \
  wget https://grafanarel.s3.amazonaws.com/builds/grafana_4.1.1-1484211277_amd64.deb && \
  dpkg -i grafana_4.1.1-1484211277_amd64.deb && \
  apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

COPY start.sh migrate.sh /root/
COPY monitrc /etc/monitrc
COPY zabbix.conf.php /usr/share/zabbix/conf/zabbix.conf.php

RUN \
  chmod 600 /etc/monitrc && \
  sed -i -e 's/# php_value date\.timezone Europe\/Riga/php_value date\.timezone Asia\/Tokyo/g' /etc/apache2/conf-enabled/zabbix.conf && \
  sed -i -e 's/;allow_sign_up = true/allow_sign_up = false/g' /etc/grafana/grafana.ini && \
  sed -i -e 's/;allow_org_create = true/allow_org_create = false/g' /etc/grafana/grafana.ini

VOLUME ["/var/lib/mysql", "/var/lib/grafana"]

EXPOSE 80 3000 10051
CMD /root/start.sh
