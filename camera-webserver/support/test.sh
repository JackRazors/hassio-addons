#!/bin/bash
# mini script for test building purposes!
cd ..
docker build --build-arg BUILD_FROM=alpine:3.7 -t test .
docker run --rm -it -p 554:554 -p 8090:8090 -v /home/iredden/git/hassio-addons-master/hassio-addons/camera-webserver/example_config/feeds.json:/share/feeds.json \
-v /home/iredden/git/hassio-addons-master/hassio-addons/camera-webserver/example_config/options.json:/data/options.json \
-v /home/iredden/git/hassio-addons-master/hassio-addons/camera-webserver/example_config/ffserver.conf:/share/ffserver.conf test
