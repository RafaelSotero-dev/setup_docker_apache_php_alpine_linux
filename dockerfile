FROM alpine:latest
RUN apk update
RUN apk upgrade

RUN apk add apache2 php84 php84-apache2 php84-pdo_mysql php84-mysqli vim openrc

RUN chown -R apache:apache /var/www/localhost

EXPOSE 80 443

CMD [ "httpd", "-D", "FOREGROUND" ]


#### Lembre de modificar o arquivo hosts na pasta system32/driver/etc/hosts