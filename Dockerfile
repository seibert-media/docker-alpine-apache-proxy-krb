FROM alpine

MAINTAINER //SEIBERT/MEDIA GmbH <docker@seibert-media.net>

ENV REALM  SMTEST.NET
ENV KDC_IP 192.168.122.145

RUN set -x \
    && apk update && apk upgrade \
    && apk add apache2 apache2-proxy apache-mod-auth-kerb

COPY krb5.conf /etc

RUN set -x \
    && sed -i "s/@@REALM@@/${REALM}/" /etc/krb5.conf \
    && sed -i "s/@@KDC_IP@@/${KDC_IP}/" /etc/krb5.conf \
    && sed -i 's/^LoadModule proxy_fdpass_module/#LoadModule proxy_fdpass_module/' /etc/apache2/conf.d/proxy.conf \
    && sed -i "s/^#LoadModule slotmem_shm_module/LoadModule slotmem_shm_module/" /etc/apache2/httpd.conf \
    && echo "IncludeOptional /etc/apache2/vhost.d/*.conf" >> /etc/apache2/httpd.conf \
    && mkdir /run/apache2 /etc/apache2/vhost.d

CMD httpd -D FOREGROUND
