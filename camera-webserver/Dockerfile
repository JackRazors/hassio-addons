ARG BUILD_FROM
FROM $BUILD_FROM

EXPOSE 8090
EXPOSE 554

RUN wget -O /usr/sbin/run-one https://raw.githubusercontent.com/dustinkirkland/run-one/master/run-one
RUN chmod +x /usr/sbin/run-one
RUN ln -sf /usr/sbin/run-one /usr/sbin/run-one-constantly

MAINTAINER Ian <razorjack@gmail.com>
RUN apk add --no-cache ffmpeg jq bash
WORKDIR /data

ADD run.sh /run.sh

ENTRYPOINT ["/run.sh"]
