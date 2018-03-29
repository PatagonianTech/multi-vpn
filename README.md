# Multi OpenVPN Connect

Connect to multiple _VPNs_ (Only **OpenVPN**) at the same time.

## Requirements

* [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

## Setup

On first use, the `docker image` will be builded.

## Usage

### Connect to VPN

```bash
./vpn-connect my-vpn
```

### Connect to Server (in the VPN)

```bash
./vpn-ssh my-vpn server1
```

### Open `bash` terminal with VPN connection

```bash
./vpn-bash my-vpn
  scp /home/myuser/file.txt server2:/tmp/file.txt
  ssh server1
```

### Connect to VPN Network

Connect host network to VPN network.

**You can connect to onaly one VPN network to host at the same time.**

```bash
./vpn-connect my-vpn -net
```

### Use a Browser into VPN

#### Firefox

```bash
./vpn-firefox my-vpn
```

#### Google Chrome

```bash
./vpn-chrome my-vpn
```

## Structure

```
ROOT/
  vpn-name/
    client.ovpn [REQUIRED]
    ssh/ [OPTIONAL]
      KEY_NAME.pem [OPTIONAL]
      config [OPTIONAL]
    scripts/ [OPTIONAL]
      pre-vpn-vpn-connect [OPTIONAL]
      pre-vpn-connect [OPTIONAL]
```

#### ssh/config

_SSH_ config file.

#### ssh/KEY_NAME.pem

_PEM_ file required to connect to server.

#### scripts/pre-vpn-vpn-connect

_Script_ to run into container **before** connect to _VPN_.

#### scripts/pre-vpn-connect

_Script_ to run into container **after** connected to _VPN_ and **before** connect to client (_ssh_ or _browser_).

### Example

```
ROOT/
  vpn-1/
    client.ovpn
    scripts/
      pre-vpn-vpn-connect
      pre-vpn-connect
    ssh/
      key1.pem
      config
  vpn-2/
    client.ovpn
    ssh/
      key2.pem
      config
  vpn-3/
    client.ovpn
    ssh/
      key2.pem
  vpn-4/
    client.ovpn
    ssh/
      config
  vpn-5/
    client.ovpn
  vpn-connect
  vpn-*
  vpn-ssh
```

First, connect to **VPN**:

```bash
# One conection by terminal
./vpn-connect vpn-1
```

To disconect, only press `CTRL+c`.

Next, connect in new terminal to each server in the **VPN**:

```bash
./vpn-ssh vpn-1 server-in-config-file-1
./vpn-ssh vpn-1 server-in-config-file-2 bash
./vpn-ssh vpn-1 usr@10.0.0.5
./vpn-ssh vpn-1 -p 2022 usr@10.0.0.5
```

## TODO

* Implement `scp`.
* Implement port forward.
