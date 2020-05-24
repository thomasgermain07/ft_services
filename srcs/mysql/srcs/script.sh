#! bin/bash

service mariadb setup
service mariadb start
mysql -u root -e "CREATE DATABASE wordpress"
mysql -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY 'test123'"
mysql -u root -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'%' WITH GRANT OPTION"
mysql -u root -e "FLUSH PRIVILEGES"
