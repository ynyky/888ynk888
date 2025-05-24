#!/bin/bash
docker exec -it onlyoffice sed -i 's/"rejectUnauthorized": true/"rejectUnauthorized": false/g' /etc/onlyoffice/documentserver/default.json
docker exec -it onlyoffice sed -i 's/"header": "Authorization"/"header": "AuthorizationJwt"/g' /etc/onlyoffice/documentserver/local.json
docker exec -it onlyoffice supervisorctl restart all



#CONFIG_FILE="/var/lib/docker/volumes/nextcloud_nextcloud_data/_data/config/config.php"
#
## Check if config.php contains 'onlyoffice' config
#if sudo grep -q "'onlyoffice'" "$CONFIG_FILE"; then
#    echo "✅ 'onlyoffice' config already exists in config.php. Nothing to do."
#else
#    echo "⏳ 'onlyoffice' config not found. Appending..."
#
#    # Insert before the last closing );
#    sudo sed -i '$i \
#  '\''onlyoffice'\'' =>\
#  array (\
#    '\''jwt_secret'\'' => '\''mysecret'\'',\
#    '\''jwt_header'\'' => '\''AuthorizationJwt'\''\
#  ),' "$CONFIG_FILE"
#
#    echo "✅ 'onlyoffice' config appended successfully."
#fi

CONFIG_FILE="/var/lib/docker/volumes/nextcloud_nextcloud_data/_data/config/config.php"

# Check if config.php contains 'onlyoffice' config
if sudo grep -q "'onlyoffice'" "$CONFIG_FILE"; then
    echo "✅ 'onlyoffice' config already exists in config.php. Nothing to do."
else
    echo "⏳ 'onlyoffice' config not found. Appending..."

    # Insert before the last closing );
    sudo sed -i '$i \
  '\''onlyoffice'\'' =>\
  array (\
    '\''documentserver'\'' => '\''https://onlyoffice.sputnik.local'\'',\
    '\''jwt_secret'\'' => '\''mysecret'\'',\
    '\''jwt_header'\'' => '\''AuthorizationJwt'\'',\
    '\''verify_peer_off'\'' => true\
    )\
  ),' "$CONFIG_FILE"

    echo "✅ 'onlyoffice' config appended successfully."
fi

