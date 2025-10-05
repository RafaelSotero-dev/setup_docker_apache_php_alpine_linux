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
php84-curl \
php84-xmlwriter \
php84-xmlreader \
php84-xml \
nodejs-current \
npm

COPY config/apache2/conf.d/vhosts/*.conf /etc/apache2/conf.d/

## Cria um link simbólico para um arquivo ou diretório // caso não faça esse passo 
## sempre que for chamar o php terá que escrever da seguinte forma: php84 ...
RUN ln -s /usr/bin/php84 /usr/bin/php

## instalando o Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === 'ed0feb545ba87161262f2d45a633e34f591ebb3381f2e0063c345ebea4d228dd0043083717770234ec00c5a9f9593792') { echo 'Installer verified'.PHP_EOL; } else { echo 'Installer corrupt'.PHP_EOL; unlink('composer-setup.php'); exit(1); }"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

RUN composer global require laravel/installer

RUN export PATH=$PATH:$HOME/.composer/vendor/bin

RUN chown -R apache:apache /var/www/localhost

EXPOSE 80 443

CMD [ "httpd", "-D", "FOREGROUND" ]


#### Lembre de modificar o arquivo hosts na pasta system32/driver/etc/hosts