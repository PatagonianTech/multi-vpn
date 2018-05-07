FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
  openvpn ssh ssh-askpass \
  net-tools iptables iputils-ping net-tools \
  firefox sudo

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update && apt-get install -y \
  google-chrome-stable curl wget

RUN apt-get autoremove \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

ARG HOST_USER=1000
ARG HOST_GROUP=1000

ENV VPNDEV_HOME='/opt/vpndeveloper'
ENV HOST_USER=${HOST_USER}
ENV HOST_GROUP=${HOST_GROUP}

RUN mkdir -p ${VPNDEV_HOME} && \
    echo "vpndeveloper:x:${HOST_USER}:${HOST_GROUP}:Developer,,,:${VPNDEV_HOME}:/bin/bash" >> /etc/passwd && \
    echo "vpndeveloper:x:${HOST_USER}:" >> /etc/group && \
    echo "vpndeveloper ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vpndeveloper && \
    chmod 0440 /etc/sudoers.d/vpndeveloper && \
    chown vpndeveloper:vpndeveloper -R ${VPNDEV_HOME}

VOLUME ${VPNDEV_HOME}
COPY run.sh /run.sh
COPY vpndeveloper.sh /vpndeveloper.sh
COPY scp.sh /scp.sh

WORKDIR /vpn
ENTRYPOINT ["/run.sh"]
CMD ["client.ovpn"]
