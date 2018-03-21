FROM wordpress:php7.2

# Install the packages I usually need
RUN apt-get update && apt-get install -y \
        zlib1g-dev \
		libmemcached-dev \
        git \
	&& apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Install Memcached
RUN git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
	&& cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
	&& docker-php-ext-configure memcached \
	&& docker-php-ext-install memcached

ADD wp-config.php /var/www/html/
