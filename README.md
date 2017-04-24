# happyshop-rpibootstrap
Happyshop bootstrapper for Raspberry Pi
Raspbery Pi 1 may not work.

## Step 1: Install Raspbian with Watterott Display support.

Direct download link: http://www.watterott.net/fbtft/2017-03-02-raspbian-lite-fbtft-rpi-display.zip

## Install happyshop using this bootstrapper script

SSH hint: New versions of Raspbian have SSH disabled by default. If you want SSH remote access, then you need to create a file called 'SSH' in boot partition.

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
