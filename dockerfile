FROM alpine:latest
RUN apk update
RUN apk upgrade

RUN apk add apache2 \
php84 \
php84-apache2 \
php84-pdo_mysql \
php84-mysqli \
vim openrc \
php84-phar \
php84-iconv \
zlib \
php84-ctype \
php84-dom \
php84-fileinfo \
php84-mbstring \
php84-session \
php84-tokenizer \
php84-curl

COPY config/apache2/conf.d/vhosts/*.conf /etc/apache2/conf.d/

## Cria um link simbólico para um arquivo ou diretório // caso não faça esse passo 
## sempre que for chamar o php terá que escrever da seguinte forma: php84 ...
RUN ln -s /usr/bin/php84 /usr/bin/php

RUN chown -R apache:apache /var/www/localhost

EXPOSE 80 443

CMD [ "httpd", "-D", "FOREGROUND" ]


#### Lembre de modificar o arquivo hosts na pasta system32/driver/etc/hosts