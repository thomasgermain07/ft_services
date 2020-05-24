FROM alpine

RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring \
	php7-json php7-session openrc

RUN openrc boot

RUN mkdir var/www
RUN mkdir var/www/phpmyadmin
COPY srcs/phpmyadmin /var/www/phpmyadmin

EXPOSE 5000
CMD service php-fpm7 start; php -S 0.0.0.0:5000 -t var/www
