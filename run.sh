#!/bin/bash

RESOLVER_NAME=${RESOLVER_NAME:-"dnscrypt.eu-nl"}

mkdir -p /opt/dnscrypt-proxy/share/dnscrypt-proxy/
cd /opt/dnscrypt-proxy/share/dnscrypt-proxy/
wget -O "dnscrypt-resolvers.csv" https://raw.githubusercontent.com/jedisct1/dnscrypt-resolvers/master/v1/dnscrypt-resolvers.csv
 

/opt/dnscrypt-proxy/sbin/dnscrypt-proxy --local-address=0.0.0.0:53 --resolver-name=${RESOLVER_NAME}
