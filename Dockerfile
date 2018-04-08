FROM phusion/baseimage:0.10.1

LABEL maintainer="lcranf"

ARG ZM_VERSION
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ="American/New_York"

RUN	apt-get update && \
	apt-get -y upgrade && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold"

RUN add-apt-repository ppa:iconnor/zoneminder-master && \
    apt-get update && \
    apt-get install -y -o zoneminder=$ZM_VERSION mariadb-server libav-tools


RUN apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD [ "/sbin/my_init" ]
