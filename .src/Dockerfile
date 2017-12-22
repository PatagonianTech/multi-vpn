FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  openvpn ssh net-tools iptables iputils-ping net-tools \
  firefox sudo

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y google-chrome-stable

RUN apt-get autoremove \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

ARG HOST_USER
ARG HOST_GROUP

RUN mkdir -p /home/vpndeveloper && \
    echo "vpndeveloper:x:${HOST_USER}:${HOST_GROUP}:Developer,,,:/home/vpndeveloper:/bin/bash" >> /etc/passwd && \
    echo "vpndeveloper:x:${HOST_USER}:" >> /etc/group && \
    echo "vpndeveloper ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vpndeveloper && \
    chmod 0440 /etc/sudoers.d/vpndeveloper && \
    chown vpndeveloper:vpndeveloper -R /home/vpndeveloper

VOLUME /home/vpndeveloper
COPY run.sh /run.sh
COPY vpndeveloper.sh /vpndeveloper.sh

WORKDIR /vpn
ENTRYPOINT ["/run.sh"]
CMD ["client.ovpn"]
