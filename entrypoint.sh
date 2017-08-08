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
fi

php -S 0.0.0.0:80 -t html
