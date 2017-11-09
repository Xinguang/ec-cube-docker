#!/bin/sh

POSTGRES_SERVER_NAME=postgres
POSTGRES_USER=cube_user
POSTGRES_PASSWORD=$(openssl rand -base64 8)
POSTGRES_DB=eccube



ROOTUSER=${POSTGRES_USER}
ROOTPASS=${POSTGRES_PASSWORD}
DBNAME=${POSTGRES_DB}
DBUSER=${POSTGRES_USER}
DBPASS=${POSTGRES_PASSWORD}

docker run -d \
    --restart=always \
    --name ${POSTGRES_SERVER_NAME} \
    -e POSTGRES_USER=${POSTGRES_USER} \
    -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
    -e POSTGRES_DB=${POSTGRES_DB} \
    -p 5432:5432  \
    postgres:9-alpine


sleep 5s

docker run -d \
    --name cube \
    --restart=always \
    --link ${POSTGRES_SERVER_NAME}:postgres \
    -e DBSERVER=postgres \
    -e ROOTUSER=${POSTGRES_USER} \
    -e ROOTPASS=${POSTGRES_PASSWORD} \
    -e DBNAME=${POSTGRES_DB} \
    -e DBUSER=${POSTGRES_USER} \
    -e DBPASS=${POSTGRES_PASSWORD} \
    -e MAIL_HOST=smtp.e-business.co.jp \
    -e MAIL_USER=ebprint@e-business.co.jp \
    -e MAIL_PASS=eb123456 \
    -v $(pwd)/ec-cube:/root/plugin \
    -p 81:80 \
    -p 8443:443 \
    ebusinessdocker/eccube

sleep 30s

docker exec -it cube sh -c '
#　プラグインソースをダウンロードする
#　プラグインソースを/ec-cube-3.0.15/app/Pluginに移動する
#　php app/console plugin:develop install --code プラグインコード
#　php app/console plugin:develop enable --code プラグインコード
'
# docker rm nginx
# docker run -d --restart=always --name nginx  \
#     -p 80:80 -p 443:443  \
#     --link cube:cube \
#     -v $(pwd)/nginx.conf:/etc/nginx/conf.d/default.conf \
#     -v /home/ec2-user/ssl/.lego/certificates:/certificates nginx:alpine
