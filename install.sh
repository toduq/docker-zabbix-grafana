apt-get update
apt-get install -y wget
wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+xenial_all.deb
dpkg -i zabbix-release_3.0-1+xenial_all.deb
apt-get update
apt-get install -y --no-install-recommends mariadb-server zabbix-server-mysql zabbix-frontend-php zabbix-agent snmp php-bcmath php-mbstring php-xml

service mysql start
echo "grant all privileges on zabbix.* to zabbix@localhost;" | mysql -uroot
echo "create database zabbix character set utf8 collate utf8_bin;" | mysql -uroot
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql -uroot zabbix

sed -i -e 's/# php_value date\.timezone Europe\/Riga/php_value date\.timezone Asia\/Tokyo/g' /etc/apache2/conf-enabled/zabbix.conf
service zabbix-agent start
service zabbix-server start
service apache2 start
