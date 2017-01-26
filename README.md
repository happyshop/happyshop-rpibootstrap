# happyshop-rpibootstrap
Happyshop bootstrapper for Raspberry Pi
Raspbery Pi 1 may not work.

## Install happyshop using this bootstrapper script

If you are already logged on to your Raspberry Pi, use

```bash
curl -sSl https://raw.githubusercontent.com/happyshop/happyshop-rpibootstrap/master/happyshop-rpibootstrap.sh | bash -s <FLAVOR>
```

Otherwise you can do it remotely.

```bash
curl -sSl https://raw.githubusercontent.com/happyshop/happyshop-rpibootstrap/master/happyshop-rpibootstrap.sh | ssh pi@<IPADDRESS> 'bash -s <FLAVOR>'
```

<FLAVOR> can be for example 'mono'.
<IPADDRESS> the IP of the Raspberry Pi.
