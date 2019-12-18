#!/bin/bash
# mini script for test building purposes!
cd ..
docker login
docker build --build-arg BUILD_FROM=alpine:3.7 -t ha-rtsp-webserver .
docker tag ha-rtsp-webserver jackrazors/ha-rtsp-webserver:0.0.3
docker push jackrazors/ha-rtsp-webserver:0.0.3
