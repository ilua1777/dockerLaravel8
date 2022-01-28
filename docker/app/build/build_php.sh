#!/bin/bash

php artisan optimize

if [ -d /var/www/dev.dvor24.local/public/files ]
then
	echo 'Storage link already exists'
else
	php artisan storage:link
fi

version=$(grep -i 'VITE_APP_VERSION=' $PWD/.env | grep -oP "[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}")

read -p "Are you sure you want to delete all the old versions? Current version - $version. (y/n) " accept
if [[ $accept == 'y' || -z $accept ]]
then
	cd /var/www/dev.dvor24.local/public/build
	ls | grep -v $version | xargs rm -rf
	cd ../../
	echo 'Deletion completed'
else
	echo 'Deletion canceled'
fi

echo 'Success!'