#!/bin/sh -e

pushd /usr/local/share

  if ! [ -d happyshop-webservice ]
  then
    webservice_url=$(cat /usr/local/etc/happyshop-webservice.manifest)
    git clone ${webservice_url} happyshop-webservice
  fi

  pushd happyshop-webservice
    # start up here --- and wait until service is started ---  or implement that shoppingclient waits for service availability.
  popd

  if ! [ -d happyshop-shoppingclient ]
  then
    shoppingclient_url=$(cat /usr/local/etc/happyshop-shoppingclient.manifest)
    git clone ${shoppingclient_url} happyshop-shoppingclient
  fi

  pushd happyshop-shoppingclient
    chmod +x start-pos-client.sh
    ./start-pos-client.sh
  popd

popd
