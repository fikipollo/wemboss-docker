#!/bin/bash

if [[ "$ADMIN_USER" != "" ]]; then
    htpasswd -D /usr/local/wEMBOSS/.htpasswd admin
else
    export ADMIN_USER="admin"
fi

if [[ "$ADMIN_PASS" == "" ]]; then
    ADMIN_PASS="123"
fi

htpasswd -b /usr/local/wEMBOSS/.htpasswd $ADMIN_USER $ADMIN_PASS

sed -i 's/my $ADMIN_USER=.*;/my $ADMIN_USER="'${ADMIN_USER}'";/g' /usr/local/wEMBOSS/wEMBOSS_cgi/admin.pl

#Fix problems with mounted volumes ownership
mkdir -p /data/test
chown -R wemboss:wemboss /data

#Launch apache
apache2ctl -DFOREGROUND
