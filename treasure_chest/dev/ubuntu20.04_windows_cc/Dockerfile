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
  bison \
  mingw-w64

RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-gcc x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix 90
RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-g++ x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix 90

RUN git clone https://github.com/PirateNetwork/pirate --branch dev
RUN cd pirate && ./zcutil/build-qt-win.sh

RUN strip pirate/src/pirated.exe
RUN strip pirate/src/pirate-cli.exe
RUN strip pirate/src/pirate-tx.exe
RUN strip pirate/pirate-qt-win.exe

FROM scratch as binaries
COPY --from=builder pirate/src/pirated.exe .
COPY --from=builder pirate/src/pirate-cli.exe .
COPY --from=builder pirate/src/pirate-tx.exe .
COPY --from=builder pirate/pirate-qt-win.exe .
