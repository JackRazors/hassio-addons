#!/bin/bash
docker login
docker build --build-arg BUILD_FROM=alpine:3.11 -t ha-gas-buddy .
docker tag ha-gas-buddy jackrazors/ha-gas-buddy:0.0.1
docker push jackrazors/ha-gas-buddy:0.0.1
