FROM alpine:3.8 as build

LABEL maintainer "https://github.com/blacktop"

ENV BRO_VERSION 2.6.1

RUN apk add --no-cache zlib openssl libstdc++ libpcap geoip 
RUN apk add --no-cache -t .build-deps \
  linux-headers \
  openssl-dev \
  libpcap-dev \
  python-dev \
  geoip-dev \
  swig \
  fts \
  fts-dev\
  bash \
  musl-dev \
  zlib-dev \
  binutils \
  fts-dev \
  cmake \
  clang \
  bison \
  perl \
  make \
  flex \
  git \
  g++ \
  fts 
COPY . /tmp
RUN cd /tmp \
  && CC=gcc ./configure --prefix=/usr/local --build-type=Release \
  && make -j12\
  && make install DESTDIR=/fakeroot 

FROM alpine:3.8
RUN apk add openssl libstdc++ libpcap
COPY --from=build /fakeroot /fakeroot

CMD [ "sh" ]
