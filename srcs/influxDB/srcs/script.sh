#! bin/bash
service influxdb start
sleep 2
influx -execute "CREATE USER admin WITH PASSWORD 'test123' WITH ALL PRIVILEGES"
service telegraf start
