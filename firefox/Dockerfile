# Based on the jess/firefox Dockerfile

FROM armv7/armhf-debian
MAINTAINER Robert Grimm <grimm.rob@gmail.com>
LABEL architecture="ARMv7"

RUN apt-get update && apt-get install -y \
  ca-certificates \
  firefox-esr \
  hicolor-icon-theme \
  libasound2 \
  libgl1-mesa-dri \
  libgl1-mesa-glx \
  --no-install-recommends \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ENV LANG en-US

COPY local.conf /etc/fonts/local.conf

ENTRYPOINT [ "/usr/bin/firefox" ]
