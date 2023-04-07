# github.com/tiredofit/docker-matrix-proxy

[![GitHub release](https://img.shields.io/github/v/tag/tiredofit/docker-matrix-proxy?style=flat-square)](https://github.com/tiredofit/docker-matrix-proxy/releases)
[![Build Status](https://img.shields.io/github/workflow/status/tiredofit/docker-matrix-proxy/build?style=flat-square)](https://github.com/tiredofit/docker-matrix-proxy/actions?query=workflow%3Abuild)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/matrix-proxy.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-proxy/)
[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/matrix-proxy.svg?style=flat-square&logo=docker)](https://hub.docker.com/r/tiredofit/matrix-proxy/)
[![Become a sponsor](https://img.shields.io/badge/sponsor-tiredofit-181717.svg?logo=github&style=flat-square)](https://github.com/sponsors/tiredofit)
[![Paypal Donate](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal&style=flat-square)](https://www.paypal.me/tiredofit)

## About

This will build a Docker Image for to proxy connections to a Matrix Homeserver, and media repository.

## Maintainer

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [About](#about)
- [Maintainer](#maintainer)
- [Table of Contents](#table-of-contents)
- [Prerequisites and Assumptions](#prerequisites-and-assumptions)
- [Installation](#installation)
  - [Build from Source](#build-from-source)
  - [Prebuilt Images](#prebuilt-images)
    - [Multi Architecture](#multi-architecture)
- [Configuration](#configuration)
  - [Quick Start](#quick-start)
  - [Environment Variables](#environment-variables)
    - [Base Images used](#base-images-used)
    - [Homeserver Options](#homeserver-options)
    - [Media Proxy Options](#media-proxy-options)
    - [Well Known Options](#well-known-options)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)
- [Support](#support)
  - [Usage](#usage)
  - [Bugfixes](#bugfixes)
  - [Feature Requests](#feature-requests)
  - [Updates](#updates)
- [License](#license)

## Prerequisites and Assumptions
*  Assumes you are using some sort of SSL terminating reverse proxy such as:
   *  [Traefik](https://github.com/tiredofit/docker-traefik)
   *  [Nginx](https://github.com/jc21/nginx-proxy-manager)
   *  [Caddy](https://github.com/caddyserver/caddy)
*  Needs access to a Matrix Homeserver
*  Optional access to a Matrix Media Repository

## Installation
### Build from Source
Clone this repository and build the image with `docker build -t (imagename) .`

### Prebuilt Images
Builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/matrix-proxy).

```
docker pull tiredofit/matrix-proxy:(imagetag)
```

Builds of the image are also available on the [Github Container Registry](https://github.com/tiredofit/matrix-proxy/pkgs/container/matrix-proxy)

```
docker pull ghcr.io/tiredofit/docker-matrix-proxy:(imagetag)
```

The following image tags are available along with their tagged release based on what's written in the [Changelog](CHANGELOG.md):

| Container OS | Tag       |
| ------------ | --------- |
| Alpine       | `:latest` |

#### Multi Architecture
Images are built primarily for `amd64` architecture, and may also include builds for `arm/v7`, `arm64` and others. These variants are all unsupported. Consider [sponsoring](https://github.com/sponsors/tiredofit) my work so that I can work with various hardware. To see if this image supports multiple architecures, type `docker manifest (image):(tag)`

## Configuration

### Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [compose.yml](examples/compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.


* * *
### Environment Variables

#### Base Images used

This image relies on an [Alpine Linux](https://hub.docker.com/r/tiredofit/alpine) base image that relies on an [init system](https://github.com/just-containers/s6-overlay) for added capabilities. Outgoing SMTP capabilities are handlded via `msmtp`. Individual container performance monitoring is performed by [zabbix-agent](https://zabbix.org). Additional tools include: `bash`,`curl`,`less`,`logrotate`,`nano`.

Be sure to view the following repositories to understand all the customizable options:

| Image                                                  | Description                            |
| ------------------------------------------------------ | -------------------------------------- |
| [OS Base](https://github.com/tiredofit/docker-alpine/) | Customized Image based on Alpine Linux |
| [Nginx](https://github.com/tiredofit/docker-nginx/)    | Nginx webserver                        |

#### Homeserver Options
| Variable                    | Value                                                               | Default     |
| --------------------------- | ------------------------------------------------------------------- | ----------- |
| `HOMESERVER_TYPE`           | `synapse` only supported at this time                               | `synapse`   |
| `HOMESERVER_URL`            | URL to Matrix Homeserver eg `http://synapse:8008`                   |             |
| `ENABLE_SYNAPSE_ADMIN`      | Create proxy to Synapse Administration API                          | `FALSE`     |
| `SYNAPSE_ADMIN_ALLOWED_IPS` | IP/Networks allowed to access Synapse Admin API seperated by commas | `0.0.0.0/0` |

#### Media Proxy Options
| Variable                  | Value                                                                       | Default |
| ------------------------- | --------------------------------------------------------------------------- | ------- |
| `ENABLE_PROXY_MEDIA_REPO` | Create proxy to third party media repository                                | `FALSE` |
| `MEDIA_REPO_URL`          | URL to Media Repository eg `http://media-repo:8000`                         |         |
| `MEDIA_REPO_PROXY_LOGOUT` | Send Client logout requests to `MEDIA_REPO_URL` instead of `HOMESERVER_URL` | `TRUE`  |

#### Well Known Options
| Variable            | Value                                                     | Default |
| ------------------- | --------------------------------------------------------- | ------- |
| `ENABLE_WELL_KNOWN` | Enable serving .well-known/matrix/server and client files | `FALSE` |
| `WELL_KNOWN_CLIENT` | Homeserver base url eg `https://matrix.example.com`       |         |
| `WELL_KNOWN_SERVER` | Homeserver server info eg `matrix.example.com:443`        |         |

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is) bash
```
## Support

These images were built to serve a specific need in a production environment and gradually have had more functionality added based on requests from the community.
### Usage
- The [Discussions board](../../discussions) is a great place for working with the community on tips and tricks of using this image.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for personalized support.
### Bugfixes
- Please, submit a [Bug Report](issues/new) if something isn't working as expected. I'll do my best to issue a fix in short order.

### Feature Requests
- Feel free to submit a feature request, however there is no guarantee that it will be added, or at what timeline.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) regarding development of features.

### Updates
- Best effort to track upstream changes, More priority if I am actively using the image in a production environment.
- Consider [sponsoring me](https://github.com/sponsors/tiredofit) for up to date releases.

## License
MIT. See [LICENSE](LICENSE) for more details.
