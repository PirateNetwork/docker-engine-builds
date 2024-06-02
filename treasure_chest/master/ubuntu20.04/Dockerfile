FROM ubuntu:20.04 as builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  pkg-config \
  m4 \
  g++-multilib \
  autoconf \
  libtool \
  libncurses-dev \
  unzip \
  git \
  python3 \
  python3-zmq \
  zlib1g-dev \
  wget \
  libcurl4-gnutls-dev \
  bsdmainutils \
  curl \
  libsodium-dev \
  bison

RUN git clone https://github.com/PirateNetwork/pirate --branch master
RUN cd pirate && ./zcutil/build-qt-linux.sh

RUN strip pirate/src/pirated
RUN strip pirate/src/pirate-cli
RUN strip pirate/src/pirate-tx
RUN strip pirate/src/wallet-utility
RUN strip pirate/src/pirate-test
RUN strip pirate/pirate-qt-linux

FROM scratch as binaries
COPY --from=builder pirate/src/pirated .
COPY --from=builder pirate/src/pirate-cli .
COPY --from=builder pirate/src/pirate-tx .
COPY --from=builder pirate/src/wallet-utility .
COPY --from=builder pirate/src/pirate-test .
COPY --from=builder pirate/pirate-qt-linux .
