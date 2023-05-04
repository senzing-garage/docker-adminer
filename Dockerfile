FROM adminer:4.8.1

ENV REFRESHED_AT=2022-09-29

LABEL Name="senzing/adminer" \
     Maintainer="support@senzing.com" \
     Version="1.0.2"

HEALTHCHECK CMD ["/app/healthcheck.sh"]

# Run as "root" for system installation.

USER root

# Reinstall apk

RUN curl -o apk-tools-static-2.6.8-r1.apk http://dl-cdn.alpinelinux.org/alpine/v3.5/main/x86_64/apk-tools-static-2.6.9-r0.apk
RUN tar -zxvf apk-tools-static-2.6.8-r1.apk
RUN cd sbin
RUN ./apk.static -X http://dl-cdn.alpinelinux.org/alpine/latest-stable/main -U --allow-untrusted --initdb add apk-tools-static
RUN apk.static update
RUN ./apk.static -X http://dl-cdn.alpinelinux.org/alpine/latest-stable/main -U --allow-untrusted add apk-tools
RUN apk update

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
