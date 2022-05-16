# docker-adminer

## Overview

A docker wrapper over [Adminer](https://www.adminer.org/).

The docker image is based on [hub.docker.com/_/adminer](https://hub.docker.com/_/adminer/)
and has added support for MSSQL.

### Related artifacts

1. [DockerHub](https://hub.docker.com/r/senzing/adminer)
1. [Helm Chart](https://github.com/Senzing/charts/tree/main/charts/adminer)

### Contents

1. [Expectations](#expectations)
    1. [Space](#space)
    1. [Time](#time)
    1. [Background knowledge](#background-knowledge)
1. [Demonstrate using Docker](#demonstrate-using-docker)
    1. [Configuration](#configuration)
    1. [Default database](#default-database)
    1. [Docker network](#docker-network)
    1. [Run docker container](#run-docker-container)
1. [Develop](#develop)
    1. [Prerequisite software](#prerequisite-software)
    1. [Clone repository](#clone-repository)
    1. [Build docker image for development](#build-docker-image-for-development)
1. [Examples](#examples)
1. [Errors](#errors)
1. [References](#references)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Expectations

### Space

This repository and demonstration require 6 GB free disk space.

### Time

Budget 40 minutes to get the demonstration up-and-running, depending on CPU and network speeds.

### Background knowledge

This repository assumes a working knowledge of:

1. [Docker](https://github.com/Senzing/knowledge-base/blob/main/WHATIS/docker.md)

## Demonstrate using Docker

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[ADMINER_DEFAULT_SERVER](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md#adminer_default_server)**

### Default database

:thinking: **Optional:**  Use to specify a particular database hostname.

1. :pencil2: Specify docker network.
   Example:

    ```console
    export ADMINER_DEFAULT_SERVER=*hostname-or-ip-address*
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export ADMINER_DEFAULT_SERVER_PARAMETER="--env ADMINER_DEFAULT_SERVER=${ADMINER_DEFAULT_SERVER}"
    ```

### Docker network

:thinking: **Optional:**  Use if docker container is part of a docker network.

1. List docker networks.
   Example:

    ```console
    sudo docker network ls
    ```

1. :pencil2: Specify docker network.
   Choose value from NAME column of `docker network ls`.
   Example:

    ```console
    export SENZING_NETWORK=*nameofthe_network*
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_NETWORK_PARAMETER="--net ${SENZING_NETWORK}"
    ```

### Run docker container

1. Run docker container.
   Example:

    ```console
    sudo docker run \
      --interactive \
      --rm \
      --tty \
      ${ADMINER_DEFAULT_SERVER_PARAMETER} \
      ${SENZING_NETWORK_PARAMETER} \
      senzing/adminer
    ```

## Develop

### Prerequisite software

The following software programs need to be installed:

1. [git](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-git.md)
1. [make](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-make.md)
1. [docker](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/install-docker.md)

### Clone repository

For more information on environment variables,
see [Environment Variables](https://github.com/Senzing/knowledge-base/blob/main/lists/environment-variables.md).

1. Set these environment variable values:

    ```console
    export GIT_ACCOUNT=senzing
    export GIT_REPOSITORY=docker-adminer
    export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
    export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
    ```

1. Follow steps in [clone-repository](https://github.com/Senzing/knowledge-base/blob/main/HOWTO/clone-repository.md) to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

    ```console
    sudo docker build --tag senzing/adminer https://github.com/senzing/docker-adminer.git#main
    ```

1. **Option #2:** Using `docker` command and local repository.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo docker build --tag senzing/adminer .
    ```

1. **Option #3:** Using `make` command.

    ```console
    cd ${GIT_REPOSITORY_DIR}
    sudo make docker-build
    ```

    Note: `sudo make docker-build-development-cache` can be used to create cached docker layers.

## Examples

## Errors

1. See [docs/errors.md](docs/errors.md).

## References

1. [Adminer](https://www.adminer.org/)
    1. [GitHub](https://github.com/vrana/adminer)
