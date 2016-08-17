# alpine-apache-krb

Alpine based system with apache as reverse proxy with kerberos auth.

## Getting started

```
docker run -d --name apache -v $(pwd)/apache:/etc/apache2/vhost.d -p 80:80 --link confluence:confluence seibertmedia/alpine-apache-krb
```
