FROM alpine

RUN apk update && apk upgrade && apk add openrc influxdb
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Fix open-rc warnings
VOLUME ["/sys/fs/cgroup"]
RUN openrc boot

# Create the volume for the base

# Create and copy needed files
RUN mkdir /etc/influxdb /etc/telegraf
COPY srcs/influxdb.conf /etc/influxdb/influxdb.conf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

COPY srcs/script.sh /home/
RUN chmod +x /home/script.sh
CMD sh /home/script.sh

EXPOSE 8086
