#!/bin/bash

terminate() {
    echo "Terminating gracefully..."

    kill -SIGTERM "$FFMPEG_PID"
    kill -SIGTERM "$HTTP_SERVER_PID"

    wait "$FFMPEG_PID"
    wait "$HTTP_SERVER_PID"

    echo "Processes terminated gracefully."
    exit 0
}

trap terminate SIGTERM SIGINT

ffmpeg -re -stream_loop -1 -i /app/resources/video.mp4 -c:v libx264 -c:a aac -f hls -hls_time 10 -hls_list_size 5 -hls_flags delete_segments -hls_segment_filename 'segment_%03d.ts' playlist.m3u8 > /dev/null 2> /dev/null &
FFMPEG_PID=$!

while [ ! -e "/app/playlist.m3u8" ]; do
    sleep 1
done

python3 -m http.server 8989 > /dev/null 2> /dev/null &
HTTP_SERVER_PID=$!

wait
