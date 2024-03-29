## https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM AS builder-base

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# Copy root filesystem
COPY rootfs /
# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# install requirements
# hadolint ignore=DL3018
RUN apk update && apk add --no-cache \
    bluez \
    bluez-dev \
    boost-dev \
    curl-dev \
    git \
    g++ \
    make \
    mariadb-dev \
    mosquitto-clients \
    tzdata
           
# download and build SBFspot
WORKDIR /tmp
RUN \
    git clone https://github.com/sbfspot/SBFspot.git . \
    && sed -i s/mariadbclient/mariadb/ ./SBFspot/makefile \
    && make -C ./SBFspot mariadb \
    && sed -i s/mariadbclient/mariadb/ ./SBFspotUploadDaemon/makefile \
    && make -C ./SBFspotUploadDaemon mariadb


# runtinme container   
FROM $BUILD_FROM

ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]


# hadolint ignore=DL3018
RUN apk update && apk add --no-cache \
    bluez \
    nano \
    bluez-libs \
    libstdc++ \
    mariadb-common \
    mariadb-connector-c \
    ncurses-libs \
    libcurl \
    mosquitto-clients
    
    #tzdata=2022c-r0 
    #boost-date_time1.78 



# Copy data for add-on
WORKDIR /usr/bin/sbfspot

COPY --from=builder-base /tmp/SBFspot/mariadb/bin/SBFspot /usr/bin/sbfspot/SBFspot
COPY --from=builder-base /tmp/SBFspotUploadDaemon/mariadb/bin/SBFspotUploadDaemon /usr/bin/sbfspot/SBFspotUploadDaemon
COPY --from=builder-base /tmp/SBFspot/date_time_zonespec.csv /usr/bin/sbfspot/date_time_zonespec.csv
COPY --from=builder-base /tmp/SBFspot/TagList* /usr/bin/sbfspot/



#RUN cp /tmp/SBFspot/mariadb/bin/SBFspot /usr/bin/sbfspot \
# && cp /tmp/SBFspotUploadDaemon/mariadb/bin/SBFspotUploadDaemon /usr/bin/sbfspot \
# && cp /tmp/SBFspot/date_time_zonespec.csv /usr/bin/sbfspot \
# && cp /tmp/SBFspot/TagList* /usr/bin/sbfspot

COPY rootfs /

RUN chmod a+x /etc/services.d/sbfspot/** /usr/bin/sbfspot/**

# --- install cron ---
# set shell
RUN echo 'SHELL=/bin/bash' > /etc/crontabs/root
# update sensors after restart
RUN echo '@reboot sleep 36 && /usr/bin/sbfspot/SBFspot -v -ad0 -am0 -mqtt -finq > /dev/stdout' >> /etc/crontabs/root
# daily data SBFspot with 10 sec offset to avoid BT blocking on TriINV
RUN echo '*/5 6-22 * * *  sleep 10 && /usr/bin/sbfspot/SBFspot -v -ad1 -am0 -ae0 -mqtt > /dev/stdout' >> /etc/crontabs/root
# monthly data SBFspot
RUN echo '55 05 * * *       /usr/bin/sbfspot/SBFspot -v -sp0 -ad0 -am1 -ae1 -finq > /dev/stdout' >> /etc/crontabs/root
# start SBFspotUpload 1 min after boot disabled for TriINV
# RUN echo '@reboot sleep 60 && /usr/bin/sbfspot/SBFspotUploadDaemon -c /usr/bin/sbfspot/SBFspotUpload.cfg > /dev/stdout' >> /etc/crontabs/root
#  Log SBFspotUpload to HA logging window  defunct now in version 3.9.6+ sbfspot, using it for the timed message
RUN echo '*/5 6-22 * * * /usr/bin/sbfspot/taillog.sh' >> /etc/crontabs/root

# Labels
LABEL \
    io.hass.name="TriINV-SBFspot" \
    io.hass.description="Home Assistant addon for Bluetooth SBFspot, is an open source project to get actual and archive data out of an SMA® inverter over Bluetooth or Ethernet (Speedwire®)" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Hasqt <https://community.home-assistant.io/u/hasqt>" \
    org.label-schema.description="Home Assistant addon for Bluetooth SBFspot, is an open source project to get actual and archive data out of an SMA® inverter over Bluetooth or Ethernet (Speedwire®)" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="TriINV-SBFspot" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/habuild/hassio-addons/tree/main/haos-sbfspot" \
    org.label-schema.usage="https://github.com/habuild/hassio-addons/tree/main/haos-sbfspot/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/habuild/hassio-addons" \
    org.label-schema.vendor="Hasqt"


#Launch nginx with debug options. not working yet
#CMD [ "nginx","-g","daemon off;error_log /dev/stdout debug;" ]
