#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

# check if options.json exists
if [ ! -f "$CONFIG_PATH" ]; then
    echo "[ERR] Refer to documentation for creating an options.json!"
    exit 1
fi

# todo, get these from the config options.json
FEED_FILE=/data/$(cat $CONFIG_PATH | jq -r '.feed_file')
FFSERVER_CONF=/data/$(cat $CONFIG_PATH | jq -r '.ffserver_conf')

# check if ffserver path configuration exists
if [ ! -f "$FFSERVER_CONF" ]; then
    echo "[ERR] Refer to documentation for creating a ffserver.conf ($FFSERVER_CONF) file!"
    exit 1
fi

# check if feed path configuration exists
if [ ! -f "$FEED_FILE" ]; then
    echo "[ERR] Refer to documentation for creating a feeds.json ($FEED_FILE) file!"
    exit 1
fi

echo "[INFO] Starting 'ffserver' with nohup ..."
ffserver -f $FFSERVER_CONF &
sleep 2

for url in `cat $FEED_FILE | jq -r 'values[]'`
do
	count=$((count + 1))
	echo "[INFO] Running: 'ffmpeg -loglevel error -rtsp_transport tcp -i \"$url\" -c:v copy \"http://localhost:8090/camera$count.ffm\"'"
	nohup ffmpeg -loglevel error -rtsp_transport tcp -i "$url" -c:v copy "http://localhost:8090/camera$count.ffm" > nohup.ffmpeg.$count.out &
done

SERVICE="ffserver"
PID=$(pgrep -x $SERVICE)
echo "[INFO] $SERVICE as PID: $PID is running ..."

while true;
do
	if pgrep -x $SERVICE >/dev/null
	then
            # everything is good!
            sleep 5
	else
	    echo "[ERR] $SERVICE has stopped!"
	    exit 1
	fi
done


