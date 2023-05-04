FROM adminer:4.8.1@sha256:576c60c6b64c7fa773c63bc1be8d80213a0ad63ae67f47537d3088e49540640b

ENV REFRESHED_AT=2022-09-29

LABEL Name="senzing/adminer" \
     Maintainer="support@senzing.com" \
     Version="1.0.2"

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
