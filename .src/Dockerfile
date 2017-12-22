FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  openvpn ssh net-tools iptables iputils-ping net-tools \
  firefox sudo

RUN apt-get autoremove \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

ARG HOST_USER
ARG HOST_GROUP

RUN mkdir -p /home/developer && \
    echo "developer:x:${HOST_USER}:${HOST_GROUP}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${HOST_USER}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown developer:developer -R /home/developer

COPY run.sh /run.sh
COPY firefox.sh /firefox.sh

WORKDIR /vpn
ENTRYPOINT ["/run.sh"]
CMD ["client.ovpn"]
