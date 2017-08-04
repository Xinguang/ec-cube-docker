FROM centos:7
MAINTAINER Wang Xinguang <wangxinguang@e-business.co.jp>

ENV ROOTUSER=postgres
ENV ROOTPASS=password

ENV DBSERVER=postgres
ENV DBNAME=cube3_dev
ENV DBUSER=cube3_dev_user
ENV DBPORT=5432
ENV DBPASS=password

COPY entrypoint.sh /entrypoint.sh

RUN cp /etc/localtime /root/old.timezone && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    chmod +x /entrypoint.sh && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7  && \
    yum update -y && \
    yum install -y php php-pdo php-pdo_pgsql php-dom php-mbstring php-gd php-xml && \
    yum install -y epel-release && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7  && \
    yum install -y php-mcrypt php-apc && \
    yum clean all && \

    curl -Ss -o eccube.tar.gz https://codeload.github.com/EC-CUBE/ec-cube/tar.gz/3.0.15 && \
    tar -zxvf eccube.tar.gz -C / && \
    rm eccube.tar.gz && \
    cd /ec-cube-3.0.15
    # php eccube_install.php pgsql

COPY php.ini /etc/php.ini
WORKDIR /ec-cube-3.0.15
VOLUME /ec-cube-3.0.15/html/upload
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
