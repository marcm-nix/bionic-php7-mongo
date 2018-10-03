FROM ubuntu:18.04

MAINTAINER Marcin Moskal

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y autoconf pkg-config libssl-dev php-pear php7.2-dev libyaml-dev unzip
RUN pecl install mongodb
RUN pecl install yaml

RUN apt-get install -y \
        git \
        libfreetype6-dev \
        curl php7.2-common \
		php7.2-curl php7.2-gd \
	    php7.2-intl \
	    php7.2-json php7.2-xml \
	    php7.2-mbstring php7.2-soap php7.2-zip \
	    php7.2-cli php7.2-odbc php7.2-pgsql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

# Cleanup
RUN apt-get autoremove -y && \
	apt-get clean && \
	apt-get autoclean && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "extension=mongodb.so" >> /etc/php/7.2/mods-available/mongodb.ini && \
    ln -s /etc/php/7.2/mods-available/mongodb.ini /etc/php/7.2/cli/conf.d/20-mongodb.ini

RUN echo "extension=yaml.so" >> /etc/php/7.2/mods-available/yaml.ini && \
    ln -s /etc/php/7.2/mods-available/yaml.ini /etc/php/7.2/cli/conf.d/20-yaml.ini

# Add application
RUN mkdir -p /app
WORKDIR /app

CMD bin/console server:run '*:80'
