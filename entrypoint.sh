#!/bin/bash

# ec-cube-3.0.15
if [[ ! -d /ec-cube-3.0.15/src ]]; then
	curl -Ss -o eccube.tar.gz https://codeload.github.com/EC-CUBE/ec-cube/tar.gz/3.0.15
	tar -zxvf eccube.tar.gz -C / 
	rm eccube.tar.gz
fi

# composer
if [[ ! -d /ec-cube-3.0.15/vendor ]]; then
	composer install
fi

# install
installfile="/ec-cube-3.0.15/html/install.php"
if [ -f "$installfile" ]
then
	echo "$file found."
	SKIP_CREATEDB=""
	if [ ${DB_CREATE}x == "false"x ]; then
	  SKIP_CREATEDB='--skip-createdb'
	fi
	SKIP_INITDB=""
	if [ ${DB_INIT}x == "false"x ]; then
	  SKIP_INITDB='--skip-initdb'
	fi
  php eccube_install.php ${DB_TYPE} none ${SKIP_CREATEDB} ${SKIP_INITDB}
  rm $installfile
	chown -R nginx *
fi

# run
php-fpm -D && /usr/sbin/nginx -g "daemon off;"
# ps aux | grep -e nginx -e php-fpm
