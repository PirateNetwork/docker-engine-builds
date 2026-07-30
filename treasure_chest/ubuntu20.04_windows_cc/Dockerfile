FROM ubuntu:20.04 as builder
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  pkg-config \
  cmake \
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
  mingw-w64 \
  zip

RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-gcc x86_64-w64-mingw32-gcc /usr/bin/x86_64-w64-mingw32-gcc-posix 90
RUN update-alternatives --install /usr/bin/x86_64-w64-mingw32-g++ x86_64-w64-mingw32-g++ /usr/bin/x86_64-w64-mingw32-g++-posix 90

RUN git clone https://github.com/PirateNetwork/pirate --branch master
RUN cd pirate && ./zcutil/build-qt-win.sh -j12

# build-qt-win.sh already strips artifacts/bin/ (with the correct
# x86_64-w64-mingw32-strip) and packages it into artifacts/bin/*.zip
# (pirate-qt-*, pirate-cli-*; no .deb - dpkg-deb doesn't apply to a Windows
# target) - nothing left to strip here.

FROM scratch as binaries
COPY --from=builder pirate/artifacts/bin/*.zip .
