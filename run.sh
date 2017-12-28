#!/bin/bash

RESOLVER_1=${RESOLVER_NAME:-"dnscrypt.eu-nl"}
RESOLVER_2=${RESOLVER_NAME:-"dns.btr.zone"}
RESOLVER_3=${RESOLVER_NAME:-"securedns"}

/opt/dnscrypt-proxy/sbin/dnscrypt-proxy --local-address=0.0.0.0:53 --resolver-name=${RESOLVER_1} &&
/opt/dnscrypt-proxy/sbin/dnscrypt-proxy --local-address=0.0.0.0:53 --resolver-name=${RESOLVER_2} &&
/opt/dnscrypt-proxy/sbin/dnscrypt-proxy --local-address=0.0.0.0:53 --resolver-name=${RESOLVER_3}
