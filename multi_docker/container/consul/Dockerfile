FROM alpine:latest

ENV CONSUL_VERSION 0.6.3
ENV CONSUL_SHA256 b0532c61fec4a4f6d130c893fd8954ec007a6ad93effbe283a39224ed237e250

ADD https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip /tmp/consul.zip
RUN echo "${CONSUL_SHA256}  /tmp/consul.zip" > /tmp/consul.sha256 \
  && sha256sum -c /tmp/consul.sha256 \
  && cd /bin \
  && unzip /tmp/consul.zip \
  && chmod +x /bin/consul \
  && rm /tmp/consul.zip

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
ENV DNS_RESOLVES consul
ENV DNS_PORT 53

ADD ./config /config/

ENTRYPOINT ["/bin/consul"]

