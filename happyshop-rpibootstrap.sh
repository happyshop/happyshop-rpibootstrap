#!/bin/sh -e

flavor="${1// }"
if [[ -z "$flavor" ]]
then
  echo "You must specify a flavor in which the Raspberry Pi should run."
  exit 2
fi

echo "Parameter flavor is ${flavor}"

if ! [ "$(whoami)" == "pi" ]
then
  echo "You are not running this script from a Raspberry Pi (user should be pi but is $(whoami))."
  exit 1
fi

sudo /bin/sh -e - << EOF

  MYSQL_SERVER_PASSWORD=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13 ; echo '')

  apt update
  apt upgrade -y

  echo "mysql-server mysql-server/root_password password ${MYSQL_SERVER_PASSWORD}" | debconf-set-selections
  echo "mysql-server mysql-server/root_password_again password ${MYSQL_SERVER_PASSWORD}" | debconf-set-selections

  apt install -y mysql-server mono-runtime unzip git curl xinit xserver-xorg ttf-anonymous-pro unclutter fonts-fantasque-sans apache2 php5 libapache2-mod-php5 php5-gd php5-mysql php-fpdf libphp-phpmailer php5-cli php5-common php5-curl php5-json php5-ldap php5-readline

  echo -n ${flavor} > /usr/local/etc/happyshop_flavor
  echo "Selected flavor is $(cat /usr/local/etc/happyshop_flavor)"
  
  echo -n "${MYSQL_SERVER_PASSWORD}" > /usr/local/etc/mysql_root_password

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
  sed -i '20i (cd /usr/local/share/happyshop-rpibootstrap && git pull && ./happyshop-start-pos-client.sh)&\n' /etc/rc.local

  echo "###"
  echo "### The MySQL server password is ${MYSQL_SERVER_PASSWORD}"
  echo "###"
  echo "### Please write down this password before closing or clearing this terminal session."
  echo "###"

EOF

sync
# sudo reboot

exit 0
