FROM alpine

RUN apk add vsftpd openrc openssl 
RUN openrc boot

COPY srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf
VOLUME [ "/sys/fs/cgroup" ]
# Creating user
RUN adduser -D admin
RUN echo "admin:test123" | chpasswd

# Generating SSL files
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /etc/ssl/private/key.pem -out /etc/ssl/private/cert.pem

# Preparating the user files
RUN mkdir /home/admin/ftp
RUN chown nobody:nogroup /home/admin/ftp
RUN chmod a-w /home/admin/ftp
RUN mkdir /home/admin/ftp/files
RUN chown admin:admin /home/admin/ftp/files
RUN echo "admin" | tee -a /etc/vsftpd/vsftpd.userlist

CMD vsftpd

EXPOSE 21 20
