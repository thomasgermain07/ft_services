FROM alpine

RUN apk update && apk upgrade && apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli \
        php7-zlib php7-curl php7-mbstring php7-json php7-session openrc
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Fix open-rc warnings
RUN openrc boot
VOLUME [ "/sys/fs/cgroup" ]

# Create the files for phpmyadmin files
RUN mkdir -p /var/www/wordpress

# Copy files to the container
COPY srcs/wordpress /var/www/wordpress
COPY srcs/telegraf.conf /etc/telegraf.conf.d/

CMD service php-fpm7 start; service telegraf start; php -S 0.0.0.0:5050 -t /var/www

EXPOSE 5050
