FROM alpine

# Install all needed
RUN apk update && apk upgrade && apk add nginx php7-fpm openssl openrc --no-cache

VOLUME [ "/sys/fs/cgroup" ]

# Replacing the default config
COPY srcs/index.html /var/lib/nginx/html
RUN rm -f /etc/nginx/init.d/default.conf
COPY srcs/default.conf /etc/nginx/conf.d/

# Generate SSL keys
RUN mkdir /ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /ssl/key.pem -out /ssl/cert.pem

# Booting openrc
RUN openrc boot

# Open ports
EXPOSE 80 443

# Start nginx at the run
# COPY srcs/startup.sh /home
# RUN chmod +x /home/startup.sh
# CMD sh /home/startup.sh && sh 
# ENTRYPOINT service php-fpm7 start && service nginx start && sh
