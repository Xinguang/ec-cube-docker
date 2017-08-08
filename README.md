### environment for ec-cube3

- How to run

```sh
# pgsql or mysql
DB_TYPE=pgsql
# The host name of postgres (or ip address)
POSTGRES_SERVER_NAME=postgres_dev_server
# The user of postgres server
POSTGRES_USER=cube3_dev_user
# Password
POSTGRES_PASSWORD="password"
# Database name
POSTGRES_DB=cube3_dev

# Super user of the postgres server
ROOTUSER=${POSTGRES_USER}
# The password of super user
ROOTPASS=${POSTGRES_PASSWORD}
# Database name
DBNAME=${POSTGRES_DB}
# user of postgres server
DBUSER=${POSTGRES_USER}
# Password
DBPASS=${POSTGRES_PASSWORD}

docker run -d \
    --name ${POSTGRES_SERVER_NAME} \
    -e POSTGRES_USER=${POSTGRES_USER} \
    -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
    -e POSTGRES_DB=${POSTGRES_DB} \
    postgres:9.2-alpine


docker run -it \
    --name cube3dev \
    --link ${POSTGRES_SERVER_NAME}:postgres \
    -e DBSERVER=postgres \
    -e ROOTUSER=${POSTGRES_USER} \
    -e ROOTPASS=${POSTGRES_PASSWORD} \
    -e DBNAME=${POSTGRES_DB} \
    -e DBUSER=${POSTGRES_USER} \
    -e DBPASS=${POSTGRES_PASSWORD} \
    -p 8080:80 \
     ebusinessdocker/eccube sh
```
