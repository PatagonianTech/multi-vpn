# Multi OpenVPN Connect

Connect to multiple _VPNs_ (Only **OpenVPN**) at the same time.

## Requirements

* [Docker](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

## Usage

### Connect to a VPN

```bash
./connect.sh my-vpn
```

### Connect to Server (in the VPN)

```bash
./ssh.sh my-vpn server1
```

### Open `bash` terminal with VPN connection

```bash
./bash.sh my-vpn
  ssh server1
```

### Structure

```
ROOT/
  vpn-name/
    client.ovpn [REQUIRED]
    ssh/ [OPTIONAL]
      KEY_NAME.pem [OPTIONAL]
      config [OPTIONAL]
```

#### Example

```
ROOT/
  vpn-1/
    client.ovpn
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
  connect.sh
  debug.sh
  ssh.sh
```

First, connect to **VPN**:

```bash
# One conection by terminal
./connect.sh vpn-1
```

To disconect, only press `CTRL+c`.

Next, connect in new terminal to each server in the **VPN**:

```bash
./ssh.sh vpn-1 server-in-config-file-1
./ssh.sh vpn-1 server-in-config-file-2 bash
./ssh.sh vpn-1 usr@10.0.0.5
./ssh.sh vpn-1 -p 2022 usr@10.0.0.5
```

## TODO

* Implement `scp`.
* Implement port forward.
