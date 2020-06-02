FROM alpine

RUN apk update && apk upgrade && apk add openrc vsftpd openssl
RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted

# Copy files to containers
COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY srcs/telegraf.conf /etc/telegraf.conf.d/

# Fix open-rc warnings
RUN openrc boot
VOLUME ["/sys/fs/cgroup"]

# Creating user
RUN adduser -D admin
RUN echo "admin:test123" | chpasswd

# Generating SSL files
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /etc/ssl/private/key.pem -out /etc/ssl/private/cert.pem

# Preparating the user files
RUN mkdir -p var/run/vsftpd/empty
RUN mkdir /home/admin/ftp
RUN chown nobody:nogroup /home/admin/ftp
RUN chmod a-w /home/admin/ftp
RUN mkdir /home/admin/ftp/files
RUN chown admin:admin /home/admin/ftp/files
RUN echo "admin" | tee -a /etc/vsftpd/vsftpd.userlist

COPY srcs/script.sh /home/
RUN chmod +x /home/script.sh
CMD service telegraf start; sh /home/script.sh

EXPOSE 21 30000-30006
