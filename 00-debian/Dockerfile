# armv7/armhf-debian with updates

FROM armv7/armhf-debian
MAINTAINER Robert Grimm <grimm.rob@gmail.com>
LABEL architecture="ARMv7"

RUN apt-get update && apt-get dist-upgrade -y && apt-get clean

ENV LANG en-US
