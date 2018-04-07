FROM phusion/baseimage:0.10.1

LABEL maintainer="lcranf"

ENV TZ="American/New_York"

RUN	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y dist-upgrade



RUN apt-get -y clean && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

CMD [ "/sbin/my_init" ]
