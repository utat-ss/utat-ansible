# Dockerfile for creating a container with https://github.com/hfaran/slack-export-viewer
# Created by Reid Sox-Harris, 08 October 2022

FROM python:3
RUN pip install slack-export-viewer
WORKDIR /app

ENTRYPOINT slack-export-viewer --ip 0.0.0.0 --port 8083 --no-browser --archive /app/exports/*.zip
