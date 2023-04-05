ARG DISTRO=alpine
ARG DISTRO_VARIANT=3.17

FROM docker.io/tiredofit/nginx:${DISTRO}-${DISTRO_VARIANT}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ENV NGINX_SITE_ENABLED=matrix-proxy \
    NGINX_WORKER_PROCESSES=1 \
    NGINX_ENABLE_CREATE_SAMPLE_HTML=FALSE \
    IMAGE_NAME="tiredofit/matrix-proxy" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-matrix-proxy/"

RUN source assets/functions/00-container && \
    set -x && \
    package update && \
    package upgrade && \
    package cleanup

COPY install /

