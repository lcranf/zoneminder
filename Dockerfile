FROM phusion/baseimage:0.10.1

LABEL maintainer="lcranf"

ARG ZM_VERSION
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="American/New_York"

RUN add-apt-repository "deb http://ppa.launchpad.net/iconnor/zoneminder-master/ubuntu $(lsb_release -s -c) main" && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 776FFB04 && \
    apt-get update && \
    echo "Installing Zoneminder version ${ZM_VERSION}" && \
    apt-get install -y zoneminder mariadb-server libav-tools && \
    apt-get install -y libvlc-dev libvlccore-dev libapache2-mod-perl2 vlc && \
    apt-get install -y ntp dialog ntpdate ffmpeg php7.0-gd

RUN adduser www-data video && \
    a2enmod cgi && \
    a2enconf zoneminder && \
    chown -R www-data:www-data /usr/share/zoneminder/ && \
    a2enmod rewrite && \
    chmod 740 /etc/zm/zm.conf && \
	chown root:www-data /etc/zm/zm.conf

RUN mkdir -p /etc/service/zoneminder
COPY ./service/zoneminder.sh /etc/service/zoneminder/run
RUN chmod +x /etc/service/zoneminder/run

RUN mkdir -p /etc/service/apache2 /var/log/apache2 ; sync;
COPY ./service/apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run && \
    chown -R www-data /var/log/apache2

RUN mkdir -p /etc/my_init.d
COPY ./startup/* /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*.sh

RUN apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD [ "/sbin/my_init" ]
