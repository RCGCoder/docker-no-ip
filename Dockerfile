FROM alpine:latest
MAINTAINER rcgcoder <www.github.com/rcgcoder>

VOLUME /noip-client
WORKDIR /noip-client/config
WORKDIR /noip-client/files

ADD https://www.noip.com/client/linux/noip-duc-linux.tar.gz /noip-clientfiles/

RUN set -x \
  && chmod a+rwX /noip-client/files \
  && tar -C /noip-client/files -x -f /noip-client/files/noip-duc-linux.tar.gz noip-2.1.9-1/binaries/noip2-x86_64 \
  && mv /noip-client/files/noip-2.1.9-1/binaries/noip2-x86_64 /noip-client/files \
  && rm -rf /files/noip-2.1.9-1 /files/noip-duc-linux.tar.gz

COPY ["noip.conf", "create_config.exp", "noip.sh", "/noip-client/files/config"]
RUN chmod +x /noip-client/files/config/noip.sh

CMD /noip-client/files/config/noip.sh
