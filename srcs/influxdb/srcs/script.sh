#! bin/bash

service influxdb start
sleep 2
influx -execute "CREATE USER admin WITH PASSWORD 'test123' WITH ALL PRIVILEGES"
service telegraf start

sleep 20

while [ 1 ]
do
	sleep 5
	if [ $(service influxdb status | grep -c started) != 1 ]; then
		exit
	fi
	if [ $(service telegraf status | grep -c started) != 1 ]; then
		exit
	fi
done

