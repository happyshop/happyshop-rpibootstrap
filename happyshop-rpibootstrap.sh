#!/bin/sh -e

flavor="${1// }"
if [[ -z "$flavor" ]]
then
  echo "You must specify a flavor in which the Raspberry Pi should run."
  exit 2
fi

if ! [ "$(whoami)" == "pi" ]
then
  echo "You are not running this script from a Raspberry Pi (user should be pi but is $(whoami))."
  exit 1
fi

sudo /bin/sh -e - << EOF

#  apt update
#  apt upgrade -y
#  apt install -y mono-runtime unzip git curl xinit xserver-xorg ttf-anonymous-pro

  echo -n ${flavor} > /usr/local/etc/happyshop_flavor
  echo "Selected flavor is $(cat /usr/local/etc/happyshop_flavor)"

  cd /usr/local/share
    if ! [ -d happyshop-rpibootstrap ]
    then
      git clone https://github.com/happyshop/happyshop-rpibootstrap.git
    fi
    cd happyshop-rpibootstrap
      git pull
    cd ..
  cd ..

  if [ -f /usr/local/etc/happyshop_rc.local_backup ]
  then
    cp /usr/local/etc/happyshop_rc.local_backup /etc/rc.local
  else
    cp /etc/rc.local /usr/local/etc/happyshop_rc.local_backup
  fi
  sed -i '20i (cd /usr/local/share/happyshop-rpibootstrap && startx xterm -e happyshop-start-pos-client.sh)&\n' /etc/rc.local

EOF

sync
sudo reboot

exit 0
