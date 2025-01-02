FROM ubuntu:24.04

# install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt update && \
    apt install -y --no-install-recommends supervisor postfix rsyslog && \
    rm -rf /var/lib/apt/lists/* 

# mail server will be listening on this port
EXPOSE 1025

# add configuration files
ADD ./config/supervisord/supervisord.conf   /etc/supervisor/supervisord.conf
ADD ./config/rsyslog/rsyslog.conf           /etc/rsyslog.conf
ADD ./config/postfix/main.cf                /etc/postfix/main.cf

# configure the entrypoint
ADD ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
