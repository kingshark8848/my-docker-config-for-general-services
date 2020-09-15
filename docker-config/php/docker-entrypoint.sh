#! /bin/bash

cd /home/ 
laravel-echo-server start &

cd /var/www/
composer install
php artisan down --message="Upgrading System, Retry Later..." --retry=60
composer run-script cc
php artisan up

php-fpm
