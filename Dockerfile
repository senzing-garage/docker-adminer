FROM adminer:5.4.0@sha256:e4dd6e76b140bbae45e22cd7e9a75f90a911ab05a63f590b7eeff84d122749fe

ENV REFRESHED_AT=2023-09-29

LABEL Name="senzing/adminer" \
      Maintainer="support@senzing.com" \
      Version="1.0.3"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Install packages.

RUN apk add \
      --no-cache \
      --virtual .php-ext-deps \
      freetds \
      unixodbc \
 && apk add \
      --no-cache \
      --virtual .build-deps \
      freetds-dev \
      unixodbc-dev \
 && docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr \
 && docker-php-ext-install \
      pdo_odbc pdo_dblib \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/*

# Copy files from repository.

COPY ./rootfs /

# Runtime execution.

EXPOSE 8080
USER adminer
CMD [ "php", "-S", "[::]:8080", "-t", "/var/www/html" ]
