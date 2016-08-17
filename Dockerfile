FROM seibertmedia/alpine-apache-proxy

MAINTAINER //SEIBERT/MEDIA GmbH <docker@seibert-media.net>

ENV KDC_IP     172.16.38.10
ENV KDC_REALM  SMTEST.NET
ENV WEB_DOMAIN smtest.net

RUN set -x \
    && apk add apache-mod-auth-kerb

COPY krb5.conf /etc

RUN set -x \
    && sed -i "s/@@KDC_IP@@/${KDC_IP}/" /etc/krb5.conf \
    && sed -i "s/@@REALM@@/${KDC_REALM}/" /etc/krb5.conf \
    && sed -i "s/@@DOMAIN@@/${WEB_DOMAIN}/" /etc/krb5.conf

CMD httpd -D FOREGROUND
