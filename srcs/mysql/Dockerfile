FROM alpine

RUN apk update && apk upgrade && apk add openrc mysql mysql-client
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Fix open-rc warnings
RUN openrc boot
VOLUME [ "/sys/fs/cgroup" ]

# Copy file to the container
COPY srcs/my.cnf /etc/mysql/
COPY srcs/telegraf.conf /etc/telegraf.conf.d/
COPY srcs/script.sh /home

# Create the Volume for the base
VOLUME ["/var/lib/mysql"]

CMD service telegraf start; sh home/script.sh; tail -f /dev/null

EXPOSE 3306
