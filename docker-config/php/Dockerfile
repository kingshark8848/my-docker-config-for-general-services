FROM php:7.2-fpm

# Set working directory
WORKDIR /var/www

# Install package and PHP Core extensions
RUN apt-get update && apt-get install -y mysql-client* \
        --no-install-recommends \ 
        supervisor \
        acl \
        procps \
        vim \
        apt-utils \
        git \
        zip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libzip-dev \
        libxml2-dev \
        libssl-dev \
        libbz2-dev \
        libpng-dev \
        libxslt1-dev \
        zlib1g-dev \
        openssl \
        libcurl4-openssl-dev \
        libssl-dev \
        wget \
        gnupg \
        build-essential \
        redis-tools \
        openssh-client \
        openssh-server \
        curl \
        librdkafka-dev \
        net-tools \
        && ln -s /usr/lib/x86_64-linux-gnu/libssl.so /usr/lib 


RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install opcache \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install xml \
        && docker-php-ext-install pdo \
        && docker-php-ext-install mbstring \
        && docker-php-ext-install tokenizer \
        && docker-php-ext-install curl \
        && rm -r /var/lib/apt/lists/* \
        && sed -i 's/^\(\[supervisord\]\)$/\1\nnodaemon=true/' /etc/supervisor/supervisord.conf

# Install PECL extensions (Redis)
RUN pecl install xdebug && pecl install redis && pecl install rdkafka

# Install laravel-echo-server (Websocket Server)
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash \
    && apt-get install -y nodejs && \
    npm install -g laravel-echo-server


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Write Permission
RUN usermod -u 1000 www-data

# Not important installs
RUN apt-get update && apt-get install -y

COPY ./laravel-echo-server.json /home/
COPY ./docker-entrypoint.sh /home/
COPY ./docker-entrypoint_no-install.sh /home/
COPY ./php-fpm.conf /usr/local/etc/
COPY ./php.ini /usr/local/etc/php/

# Expose ports.

EXPOSE 9000
EXPOSE 6001

CMD ["php-fpm"]

