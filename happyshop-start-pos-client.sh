#!/bin/sh -e

flavor=$(cat /usr/local/etc/happyshop_flavor)

cd /usr/local/share

  if ! [ -d happyshop-${flavor} ]
  then
    git clone https://github.com/happyshop/happyshop-${flavor}.git
  fi

  cd happyshop-${flavor}

    ./start-pos-client.sh

  cd ..

cd ..
