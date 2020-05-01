FROM alpine

# Install all needed
RUN apk update && apk upgrade && apk add nginx sudo openssh php7-fpm openssl openrc --no-cache
#RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Replacing the default config
COPY srcs/index.html /var/lib/nginx/index.html
RUN rm -f /etc/nginx/init.d/default.conf
COPY srcs/default.conf /etc/nginx/conf.d/

# Generate SSL keys
RUN mkdir /ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /ssl/key.pem -out /ssl/cert.pem

# Add user
RUN adduser -D -u 1000 "admin"
RUN echo "admin:admin123" | chpasswd
COPY srcs/sudoers.dist /etc/sudoers
# Booting openrc
RUN openrc boot
RUN touch /run/openrc/softlevel

# Create the file for running nginx
RUN mkdir -p /run/nginx

# Open ports
EXPOSE 80 443 22

# Start nginx at the run
#RUN rc-update add telegraf
ENTRYPOINT service php-fpm7 start; service sshd start; nginx -g "daemon off;"
#ENTRYPOINT service php-fpm7 start; service telegraf start;  nginx -g "daemon off;"
