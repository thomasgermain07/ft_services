FROM alpine

# Install all needed
RUN apk update && apk upgrade && apk add openrc php7-fpm nginx sudo openssh openssl
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Fix open-rc warnings
RUN openrc boot
RUN touch /run/openrc/softlevel
VOLUME ["/sys/fs/cgroup"]

# Replacing the default config
COPY srcs/redirection /var/lib/nginx/redirection
RUN rm -f /etc/nginx/init.d/default.conf
COPY srcs/default.conf /etc/nginx/conf.d/
COPY srcs/telegraf.conf /etc/telegraf.conf.d/telegraf.conf

# Generate SSL keys
RUN mkdir /ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /ssl/key.pem -out /ssl/cert.pem

# Add user
RUN adduser -D -u 1000 "admin"
RUN echo "admin:admin123" | chpasswd
COPY srcs/sudoers.dist /etc/sudoers

# Create the file for running nginx
RUN mkdir -p /run/nginx

# Open ports
EXPOSE 80 443 22

# Start nginx at the run
COPY srcs/script.sh /home
RUN chmod +x /home/script.sh
CMD service telegraf start; service php-fpm7 start; service sshd start; service nginx start; sh /home/script.sh
