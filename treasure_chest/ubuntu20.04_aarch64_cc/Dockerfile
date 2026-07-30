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
  zip

RUN apt-get install -y \
  gcc-aarch64-linux-gnu \
  g++-aarch64-linux-gnu


RUN mkdir .cargo
RUN echo '[target.aarch64-unknown-linux-gnu]' > /.cargo/config
RUN echo 'ar = "/usr/bin/aarch64-linux-gnu-ar-9"' >> /.cargo/config
RUN echo 'linker = "/usr/bin/aarch64-linux-gnu-gcc-9"' >> /.cargo/config


RUN git clone https://github.com/PirateNetwork/pirate --branch master
RUN cd pirate && ./zcutil/build-qt-aarch64.sh -j12

# build-qt-aarch64.sh already strips artifacts/bin/ (with the correct
# aarch64-linux-gnu-strip) and packages it into artifacts/bin/*.deb and
# artifacts/bin/*.zip (pirate-qt-*, pirate-cli-*) - nothing left to strip
# here.

FROM scratch as binaries
COPY --from=builder pirate/artifacts/bin/*.deb .
COPY --from=builder pirate/artifacts/bin/*.zip .
