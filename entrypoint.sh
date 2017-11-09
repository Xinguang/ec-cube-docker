#!/bin/bash

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

php-fpm -D && /usr/sbin/nginx -g "daemon off;"
# ps aux | grep -e nginx -e php-fpm
