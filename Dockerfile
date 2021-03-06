FROM owncloud/php:latest

LABEL maintainer="ownCloud DevOps <devops@owncloud.com>" \
  org.label-schema.name="ownCloud Base" \
  org.label-schema.vendor="ownCloud GmbH" \
  org.label-schema.schema-version="1.0"

VOLUME ["/mnt/data"]

EXPOSE 80

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/usr/bin/owncloud", "server"]

RUN apt-get update -y && \
  apt-get upgrade -y && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /var/www/owncloud /mnt/data/files /mnt/data/config /mnt/data/certs /mnt/data/sessions && \
  chown -R www-data:www-data /var/www/owncloud /mnt/data && \
  chgrp root /var/run /var/lock/apache2 /var/run/apache2 /etc/environment && \
  chmod g+w /var/run /var/lock/apache2 /var/run/apache2 /etc/environment && \
  chsh -s /bin/bash www-data

COPY rootfs /
WORKDIR /var/www/owncloud

RUN chgrp root /etc/apache2/sites-enabled/default.conf /etc/php/7.2/mods-available/owncloud.ini && \
  chmod g+w /etc/apache2/sites-enabled/default.conf /etc/php/7.2/mods-available/owncloud.ini
