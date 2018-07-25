#!/bin/bash

# ec-cube-3.0.15
if [[ ! -d /ec-cube/src ]]; then
	curl -Ss -o eccube.tar.gz https://codeload.github.com/EC-CUBE/ec-cube/tar.gz/$ECCUBE_VERSION
	tar -zxvf eccube.tar.gz -C / 
	mv /ec-cube-$ECCUBE_VERSION /ec-cube && \
	rm eccube.tar.gz
fi

# composer
if [[ ! -d /ec-cube/vendor ]]; then
	composer install
fi

# install
installfile="/ec-cube/html/install.php"
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
	chown -R nobody *
fi

# run
php-fpm -D && /usr/sbin/nginx -g "daemon off;"
# ps aux | grep -e nginx -e php-fpm
