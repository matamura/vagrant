FROM alpine:latest
MAINTAINER Machiko Tamura <machiko.t@5sg.jp>

RUN apk -U upgrade

RUN apk update && \
    apk add bash haproxy zip && \
        rm -rf /var/cache/apk/*

EXPOSE 3306

RUN rm -f /etc/haproxy/*
