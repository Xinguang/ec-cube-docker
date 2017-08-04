#!/bin/bash

installfile="/ec-cube-3.0.15/html/install.php"

if [ -f "$installfile" ]
then
	echo "$file found."
  php eccube_install.php pgsql
  rm $installfile
fi

php -S 0.0.0.0:80 -t html
