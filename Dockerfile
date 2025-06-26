FROM adminer:5.3.0@sha256:730215fe535daca9a2f378c48321bc615c8f0d88668721e0eff530fa35b6e8f6

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
