FROM lsiobase/alpine.armhf
MAINTAINER vkhurana

ENV BUILD_DEPS   make gcc musl-dev git ldns-dev libevent-dev expat-dev shadow autoconf file libexecinfo-dev
ENV RUNTIME_DEPS bash util-linux coreutils findutils grep libressl ldns ldns-tools libevent expat libtool libexecinfo coreutils drill wget

RUN set -x && \
    apk --update upgrade && apk add $RUNTIME_DEPS $BUILD_DEPS

ENV LIBSODIUM_VERSION 1.0.16
ENV LIBSODIUM_SHA256 eeadc7e1e1bcef09680fb4837d448fbdf57224978f865ac1c16745868fbd0533
ENV LIBSODIUM_DOWNLOAD_URL https://download.libsodium.org/libsodium/releases/libsodium-${LIBSODIUM_VERSION}.tar.gz

RUN set -x && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget -O libsodium.tar.gz $LIBSODIUM_DOWNLOAD_URL && \
    echo "${LIBSODIUM_SHA256} *libsodium.tar.gz" | sha256sum -c - && \
    tar xzf libsodium.tar.gz && \
    rm -f libsodium.tar.gz && \
    cd libsodium-${LIBSODIUM_VERSION} && \
    env CFLAGS=-Ofast ./configure --disable-dependency-tracking && \
    make check && make install && \
    ldconfig /usr/local/lib && \
    rm -fr /tmp/* /var/tmp/*

ENV DNSCRYPT_PROXY_VERSION 1.9.5
ENV DNSCRYPT_PROXY_SHA256 64021fabb7d5bab0baf681796d90ecd2095fb81381e6fb317a532039025a9399
ENV DNSCRYPT_PROXY_DOWNLOAD_URL https://download.dnscrypt.org/dnscrypt-proxy/dnscrypt-proxy-${DNSCRYPT_PROXY_VERSION}.tar.gz

RUN set -x && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget -O dnscrypt-proxy.tar.gz $DNSCRYPT_PROXY_DOWNLOAD_URL && \
    echo "${DNSCRYPT_PROXY_SHA256} *dnscrypt-proxy.tar.gz" | sha256sum -c - && \
    tar xzf dnscrypt-proxy.tar.gz && \
    rm -f dnscrypt-proxy.tar.gz && \
    cd dnscrypt-proxy-${DNSCRYPT_PROXY_VERSION} && \
    mkdir -p /opt/dnscrypt-proxy/empty && \
    groupadd _dnscrypt-proxy && \
    useradd -g _dnscrypt-proxy -s /etc -d /opt/dnscrypt-proxy/empty _dnscrypt-proxy && \
    env CFLAGS=-Os ./configure --disable-dependency-tracking --prefix=/opt/dnscrypt-proxy --disable-plugins && \
    make install && \
    rm -fr /opt/dnscrypt-proxy/share && \
    rm -fr /tmp/* /var/tmp/*

RUN set -x && \
    apk del --purge $BUILD_DEPS && \
rm -rf /tmp/* /var/tmp/* /usr/local/include

# add local files
COPY root/ /

EXPOSE 53/tcp 53/udp
