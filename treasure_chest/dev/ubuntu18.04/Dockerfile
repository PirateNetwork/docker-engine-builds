FROM ubuntu:18.04 as builder
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

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -y
RUN apt-get update -y
RUN apt-get install gcc-9 g++-9 -y
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9

RUN git clone https://github.com/PirateNetwork/pirate --branch dev
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
