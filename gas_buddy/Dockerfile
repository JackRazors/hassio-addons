ARG BUILD_FROM
FROM $BUILD_FROM

EXPOSE 8080

MAINTAINER Ian <razorjack@gmail.com>
WORKDIR /

RUN apk add py3-lxml py3-requests py3-beautifulsoup4 py3-flask
ADD web.py /web.py
RUN chmod +x /web.py

ENTRYPOINT ["/web.py"]
