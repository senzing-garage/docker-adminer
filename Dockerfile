FROM adminer:5.4.1@sha256:01d530ceb89d1a940b80dd990fa79b49d39add22752ac789fd663de10673f3ca

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
