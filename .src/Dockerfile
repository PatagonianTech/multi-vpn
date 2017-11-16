FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y openvpn ssh net-tools

COPY run.sh /run.sh
RUN chmod a+x /run.sh

RUN apt-get autoremove \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /vpn
ENTRYPOINT ["/run.sh"]
CMD ["client.ovpn"]
