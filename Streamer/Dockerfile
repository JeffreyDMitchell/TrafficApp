FROM ubuntu

RUN apt update \
&& apt install  -y \
    ffmpeg \
    python3 

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app/resources
RUN mkdir -p /app/scripts
WORKDIR /app

# TODO: Temporary
COPY ./video.mp4 /app/resources/video.mp4
COPY ./entrypoint.sh /app/scripts/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/app/scripts/entrypoint.sh"]
