### section: base image ###
### owner: IT-OPS ###
FROM debian:bookworm-slim AS ccs-base
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      opendkim \
      joe \
      yamllint \
      gettext-base \
      rsyslog \
      vim \
      opendkim-tools && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y --no-install-recommends --no-install-suggests \
            inetutils-syslogd
RUN useradd apps && \
    mkdir -p /home/apps && chown apps:apps /home/apps && \
    chmod 777 /tmp

ENV WORKDIR /srv
ENV CODEDIR=/code
ENV PATH $WORKDIR/bin:$PATH

### section: application specific setup ###
### owner: DEV ###
### desc: install all runtime dependencies ###
FROM ccs-base AS ccs-app-base


### section: test setup ###
### owner: DEV ###
### desc: install all test dependencies and generate the artifacts

FROM ccs-app-base AS ccs-app-code
WORKDIR $CODEDIR
COPY ./ $CODEDIR
COPY bin/ $WORKDIR/bin
COPY files/ $WORKDIR/files

### section: production image ###
### owner: DEV ###
### desc: take just the needed artefacts and harden the container
FROM ccs-app-base AS ccs-app
ENV PATH=$WORKDIR/bin:$PATH
WORKDIR $WORKDIR
COPY --from=ccs-app-code $WORKDIR ./
ARG s6_overlay_ver=3.2.0.2
RUN apt-get update \
 && apt-get install -y --no-install-recommends --no-install-suggests \
            curl xz-utils \
 && curl -fL -o /tmp/s6-overlay-noarch.tar.xz \
         https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_ver}/s6-overlay-noarch.tar.xz \
 && curl -fL -o /tmp/s6-overlay-bin.tar.xz \
         https://github.com/just-containers/s6-overlay/releases/download/v${s6_overlay_ver}/s6-overlay-x86_64.tar.xz \
 && tar -xf /tmp/s6-overlay-noarch.tar.xz -C / \
 && tar -xf /tmp/s6-overlay-bin.tar.xz -C / \
    \
 # Cleanup unnecessary stuff
 && apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
            curl xz-utils \
 && rm -rf /var/lib/apt/lists/* \
           /tmp/*

ENV S6_KEEP_ENV=1 \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    S6_CMD_WAIT_FOR_SERVICES=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=5000


COPY rootfs /

 
RUN chmod +x /etc/s6-overlay/s6-rc.d/*/run \
             /etc/s6-overlay/s6-rc.d/*/*.sh
EXPOSE 8891

ENTRYPOINT ["/init"]

CMD ["opendkim", "-f"]
