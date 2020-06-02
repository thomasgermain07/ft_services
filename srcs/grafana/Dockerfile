FROM alpine

RUN apk update && apk upgrade && apk add openrc
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
RUN apk add --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main libc6-compat
RUN wget https://dl.grafana.com/oss/release/grafana-6.6.0.linux-amd64.tar.gz
RUN tar -zxvf grafana-6.6.0.linux-amd64.tar.gz && rm /grafana-6.6.0/conf/defaults.ini \
	&& rm -rf /var/cache/apk/* && rm -f grafana-6.6.0.linux-amd64.tar.gz

# Fix open-rc warnings
RUN openrc boot
VOLUME ["/sys/fs/cgroup"]

# Copy files to the container
RUN mkdir -p /var/lib/grafana/dashboards
COPY srcs/grafana.db /grafana-6.6.0/data/
COPY srcs/default.json /var/lib/grafana/dashboards/
COPY srcs/telegraf.conf /etc/telegraf.conf.d/
COPY srcs/defaults.ini /grafana-6.6.0/conf/

COPY srcs/script.sh /home/
RUN chmod +x /home/script.sh
CMD service telegraf start; sh /home/script.sh

EXPOSE 3000
