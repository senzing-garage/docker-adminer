# docker-adminer

If you are beginning your journey with [Senzing],
please start with [Senzing Quick Start guides].

You are in the [Senzing Garage]
where projects are "tinkered" on.
Although this GitHub repository may help you understand an approach to using Senzing,
it's not considered to be "production ready" and is not considered to be part of the Senzing product.
Heck, it may not even be appropriate for your application of Senzing!

## Overview

A docker wrapper over [Adminer].

The docker image is based on [hub.docker.com/\_/adminer]
and has added support for MSSQL.

### Related artifacts

1. [DockerHub]

### Contents

1. [Expectations]
   1. [Space]
   1. [Time]
   1. [Background knowledge]
1. [Demonstrate using Docker]
   1. [Configuration]
   1. [Default database]
   1. [Docker network]
   1. [Run docker container]
1. [Develop]
   1. [Prerequisite software]
   1. [Clone repository]
   1. [Build docker image for development]
1. [Examples]
1. [Errors]
1. [References]

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

1. [Docker]

## Demonstrate using Docker

### Configuration

Configuration values specified by environment variable or command line parameter.

- **[ADMINER_DEFAULT_SERVER]**

### Default database

:thinking: **Optional:** Use to specify a particular database hostname.

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

:thinking: **Optional:** Use if docker container is part of a docker network.

1. List docker networks.
   Example:

   ```console
   sudo docker network ls
   ```

1. :pencil2: Specify docker network.
   Choose value from NAME column of `docker network ls`.
   Example:

   ```console
   export SENZING_NETWORK=*name_of_the_network*
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

1. [git]
1. [make]
1. [docker]

### Clone repository

For more information on environment variables,
see [Environment Variables].

1. Set these environment variable values:

   ```console
   export GIT_ACCOUNT=senzing
   export GIT_REPOSITORY=docker-adminer
   export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
   export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
   ```

1. Follow steps in [clone-repository] to install the Git repository.

### Build docker image for development

1. **Option #1:** Using `docker` command and GitHub.

   ```console
   sudo docker build --tag senzing/adminer https://github.com/senzing-garage/docker-adminer.git#main
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

1. See [docs/errors.md].

## References

1. [Adminer]
   1. [GitHub]

[ADMINER_DEFAULT_SERVER]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md#adminer_default_server
[Adminer]: https://www.adminer.org/
[Background knowledge]: #background-knowledge
[Build docker image for development]: #build-docker-image-for-development
[Clone repository]: #clone-repository
[clone-repository]: https://github.com/senzing-garage/knowledge-base/blob/main/HOWTO/clone-repository.md
[Configuration]: #configuration
[Default database]: #default-database
[Demonstrate using Docker]: #demonstrate-using-docker
[Develop]: #develop
[Docker network]: #docker-network
[docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[Docker]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/docker.md
[DockerHub]: https://hub.docker.com/r/senzing/adminer
[docs/errors.md]: docs/errors.md
[Environment Variables]: https://github.com/senzing-garage/knowledge-base/blob/main/lists/environment-variables.md
[Errors]: #errors
[Examples]: #examples
[Expectations]: #expectations
[git]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/git.md
[GitHub]: https://github.com/vrana/adminer
[hub.docker.com/\_/adminer]: https://hub.docker.com/_/adminer/
[make]: https://github.com/senzing-garage/knowledge-base/blob/main/WHATIS/make.md
[Prerequisite software]: #prerequisite-software
[References]: #references
[Run docker container]: #run-docker-container
[Senzing Garage]: https://github.com/senzing-garage
[Senzing Quick Start guides]: https://docs.senzing.com/quickstart/
[Senzing]: https://senzing.com/
[Space]: #space
[Time]: #time
