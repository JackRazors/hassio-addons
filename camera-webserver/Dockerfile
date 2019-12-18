ARG BUILD_FROM
FROM $BUILD_FROM

EXPOSE 8090
EXPOSE 554

MAINTAINER Ian <razorjack@gmail.com>
RUN apk add --no-cache ffmpeg jq bash
WORKDIR /data

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
