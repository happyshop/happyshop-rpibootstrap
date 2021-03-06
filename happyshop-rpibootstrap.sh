#!/bin/sh -e

if ! [ "$(whoami)" == "pi" ]
then
  echo "You are not running this script from a Raspberry Pi (user should be pi but is $(whoami))."
  exit 1
fi

sudo apt update
sudo apt upgrade -y

MYSQL_SERVER_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')
sudo sh -c "echo -n \"${MYSQL_SERVER_PASSWORD}\" > /usr/local/etc/mysql_root_password"
echo "mysql-server mysql-server/root_password password ${MYSQL_SERVER_PASSWORD}" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password ${MYSQL_SERVER_PASSWORD}" | sudo debconf-set-selections

sudo apt install -y mysql-server mono-complete unzip git curl xinit xserver-xorg ttf-anonymous-pro unclutter fonts-fantasque-sans apache2 php5 libapache2-mod-php5 php5-gd php5-mysql php-fpdf libphp-phpmailer php5-cli php5-common php5-curl php5-json php5-ldap php5-readline

pushd /usr/local/share
  if ! [ -d happyshop-rpibootstrap ]
  then
    sudo git clone https://github.com/happyshop/happyshop-rpibootstrap.git
  fi

  pushd happyshop-rpibootstrap
    sudo git pull
  popd
popd

if [ -f /usr/local/etc/happyshop_rc.local_backup ]
then
  sudo cp /usr/local/etc/happyshop_rc.local_backup /etc/rc.local
else
  sudo cp /etc/rc.local /usr/local/etc/happyshop_rc.local_backup
fi
sudo sed -i '20i (cd /usr/local/share/happyshop-rpibootstrap && git pull && ./happyshop-start-pos-client.sh)&\n' /etc/rc.local

sync && sleep 1 && sync && sleep 1 && sync

echo "###"
echo "### The MySQL server password is ${MYSQL_SERVER_PASSWORD}"
echo "###"
echo "### Please write down this password before closing or clearing this terminal session."
echo "###"
echo "### You are now save to reboot the system and all services should start at boot up." 

exit 0
