FROM adminer:5.4.0@sha256:3a1399a54899a9b589885a1b508c37fec816724c7e7f9f883398f943afcebc5c

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
