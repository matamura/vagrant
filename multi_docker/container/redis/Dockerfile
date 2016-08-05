FROM alpine:latest
MAINTAINER Machiko Tamura <tamura.m@5sg.jp>

RUN apk -U upgrade

RUN apk update && \
    apk add build-base linux-headers gcc make bash ruby zip && \
        rm -rf /var/cache/apk/*

RUN mkdir -p /usr/local/src
WORKDIR /usr/local/src
RUN wget http://download.redis.io/releases/redis-3.2.1.tar.gz
RUN tar xvfz redis-3.2.1.tar.gz
RUN rm -f redis-3.2.1.tar.gz
WORKDIR redis-3.2.1/deps

RUN make hiredis jemalloc linenoise lua

WORKDIR ../

RUN gem install --no-ri --no-rdoc redis

RUN make install


ADD ./files/redis.conf /etc/redis.conf
COPY ./files/node-migrate.rb /usr/local/bin/
COPY ./files/start_server /usr/local/bin/
RUN chmod +x /usr/local/bin/start_server

COPY ./files/redis-trib.rb /usr/local/src/redis-3.2.1/src/redis-trib.rb
RUN ln -sf /usr/local/src/redis-3.2.1/src/redis-trib.rb /usr/local/bin/
RUN chmod +x //usr/local/bin/redis-trib.rb

RUN mkdir -p /var/lib/redis



WORKDIR /var/lib/redis


EXPOSE 6379

