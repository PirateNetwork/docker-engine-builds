FROM ubuntu:20.04 as builder
ENV DEBIAN_FRONTEND=interactive
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
  zip

RUN git clone https://github.com/PirateNetwork/pirate --branch master
RUN cd pirate && ./zcutil/build-qt-linux.sh -j12

# build-qt-linux.sh already strips artifacts/bin/ and packages it into
# artifacts/bin/*.deb and artifacts/bin/*.zip (pirate-qt-*, pirate-cli-*) -
# nothing left to strip here.

FROM scratch as binaries
COPY --from=builder pirate/artifacts/bin/*.deb .
COPY --from=builder pirate/artifacts/bin/*.zip .
