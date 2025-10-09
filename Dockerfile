FROM adminer:5.4.0@sha256:606d5f153ef9013aab5647000a528fbf56345ebe9bb994387f9bcf9f9cc0603b

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
