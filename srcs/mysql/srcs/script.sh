#! bin/bash

service mariadb setup
service mariadb start
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'test123'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'%' WITH GRANT OPTION"
mysql -u root -e "FLUSH PRIVILEGES"
mysql -u root  wordpress < /home/wordpress.sql

sleep 20

while [ 1 ]
do
	sleep 5
	if [ $(service mariadb status | grep -c started) != 1 ]; then
		exit
	fi
	if [ $(service telegraf status | grep -c started) != 1 ]; then
		exit
	fi
done
