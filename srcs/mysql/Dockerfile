FROM alpine

RUN apk add openrc mysql mysql-client
RUN openrc boot

# Copy conf
COPY /srcs/my.cnf /etc/mysql/

# Copy script
COPY /srcs/script.sh /home

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

CMD sh home/script.sh; tail -f /dev/null


