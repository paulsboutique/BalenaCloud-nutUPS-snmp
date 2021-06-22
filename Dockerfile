FROM balenalib/raspberry-pi2

ENV TZ=Australia/Adelaide

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone


LABEL maintainer="barnard704@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV NUT_VERSION 2.7.4

# Update and install packages
RUN apt-get update \
    && apt-get install nut curl git python3-pip python-pip tzdata nano snmpd  -yq \
    && rm -rf /var/lib/apt/lists/*
	
COPY ups.conf /etc/nut/
COPY upsmon.conf /etc/nut/
COPY upsd.users /etc/nut/
COPY snmpd.conf /etc/snmp/
COPY ups-nut.sh /etc/snmp/

# Install and configure webnut
RUN pip install setuptools \
    && pip install config \
    && mkdir /app\
    && cd /app \
    && git clone https://github.com/rshipp/python-nut2.git \
    && cd python-nut2 \
    && python setup.py install \
    && cd .. \
   && git clone https://github.com/rshipp/webNUT.git \
    && cd webNUT  \
    && pip install -e . 

# Add run and set permissions
ADD run.sh /run.sh
RUN chmod +x /run.sh

WORKDIR /app/webNUT

VOLUME ["/app/webNUT/webnut/", "/etc/nut/"]

COPY config.py /app/webNUT/webnut/

EXPOSE 3493 6543

CMD ["/run.sh"]
