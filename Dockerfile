FROM phusion/baseimage:0.10.1

LABEL maintainer="lcranf"

ARG ZM_VERSION
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"

RUN add-apt-repository "deb http://ppa.launchpad.net/iconnor/zoneminder-master/ubuntu $(lsb_release -s -c) main" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 776FFB04 && \
    apt-get update && \
    apt-get install -y zoneminder mariadb-server libav-tools && \
    apt-get install -y libvlc-dev libvlccore-dev libapache2-mod-perl2 vlc && \
    apt-get install -y ntp dialog ntpdate ffmpeg php7.0-gd

RUN adduser www-data video && \
    a2enmod cgi && \
    a2enconf zoneminder && \
    chown -R www-data:www-data /usr/share/zoneminder && \
    a2enmod rewrite && \
    chmod -R 777 etc/zm/zm.conf && \
	chown root:www-data /etc/zm/zm.conf

RUN mkdir -p /etc/service/zoneminder /var/log/zm ; sync;
COPY ./service/zoneminder.sh /etc/service/zoneminder/run
RUN chmod +x /etc/service/zoneminder/run && \
    chown -R www-data /var/log/zm

RUN mkdir -p /etc/service/apache2 /var/log/apache2 ; sync;
COPY ./service/apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run && \
    chown -R www-data /var/log/apache2 && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed  -i "s|\;date.timezone =|date.timezone = \"${TZ}\"|" /etc/php/7.0/apache2/php.ini

RUN mkdir -p /etc/service/mysql /var/log/mysql ; sync;
COPY ./service/mysql.sh /etc/service/mysql/run
RUN chmod +x /etc/service/mysql/run && \
    chown -R mysql /var/log/mysql

RUN mkdir -p /etc/my_init.d
COPY ./init/* /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh

RUN apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD [ "/sbin/my_init" ]
