# Add PHP-FPM base image
#
FROM php:8-fpm

ENV PHP_MEMORY_LIMIT=512M
ENV PHP_UPLOAD_LIMIT=512M

RUN apt-get update ; \
    apt-get upgrade ; \
    apt-get install -y \
        bzip2 \
        git \
        imagemagick \
        imagemagick-dev \
        gcc \
        g++ \
        make \
        autoconf \
        libldap-common \
        libmagickcore-6.q16-6-extra \
        rsync \
        libcurl4-openssl-dev \
        libevent-dev \
        libfreetype6-dev \
        libgd-dev \
        libgd3 \
        libgmp-dev \
        libicu-dev \
        libjpeg-dev \
        libldap2-dev \
        libmagickwand-dev \
        libmcrypt-dev \
        libmemcached-dev \
        libonig-dev \
        libpng-dev \
        libpq-dev \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        zlib1g-dev ; \
    usermod -u 1000 www-data && groupmod -g 1000 www-data ;

RUN docker-php-ext-install zlib ; exit 0
RUN cp /usr/src/php/ext/zlib/config0.m4 /usr/src/php/ext/zlib/config.m4
RUN docker-php-ext-install zlib

RUN docker-php-ext-install bz2 bcmath exif gmp intl ldap opcache pcntl sysvsem mysqli pdo_mysql zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring

RUN cd /tmp && git clone https://github.com/Imagick/imagick.git  && pecl install /tmp/imagick/package.xml  \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-enable gd


# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
RUN rm -rf /var/lib/apt/lists/*

RUN { \
        echo 'opcache.enable=1'; \
        echo 'opcache.interned_strings_buffer=32'; \
        echo 'opcache.max_accelerated_files=10000'; \
        echo 'opcache.memory_consumption=256'; \
        echo 'opcache.save_comments=1'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.jit=1255'; \
        echo 'opcache.jit_buffer_size=156M'; \
    } > "${PHP_INI_DIR}/conf.d/opcache-recommended.ini"; \
    \
    echo 'apc.enable_cli=1' >> "${PHP_INI_DIR}/conf.d/docker-php-ext-apcu.ini"; \
    { \
    echo 'log_errors=On'; \
    echo 'error_log=/proc/self/fd/2'; \
    echo 'access_log=/proc/self/fd/2'; \
    echo 'log_limit=8192'; \
    echo 'catch_workers_output=yes'; \
    echo 'decorate_workers_output=no'; \
    echo 'fastcgi.logging=On'; \
    } > "${PHP_INI_DIR}/conf.d/logging.ini"; \
    \
    { \
        echo 'memory_limit=${PHP_MEMORY_LIMIT}'; \
        echo 'upload_max_filesize=${PHP_UPLOAD_LIMIT}'; \
        echo 'post_max_size=${PHP_UPLOAD_LIMIT}'; \
    } > "${PHP_INI_DIR}/conf.d/nextcloud.ini"; \
