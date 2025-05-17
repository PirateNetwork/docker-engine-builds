FROM ubuntu:22.04 AS builder
ENV DEBIAN_FRONTEND=interactive

# Install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  autoconf \
  automake \
  autopoint \
  bash \
  bison \
  bzip2 \
  curl \
  flex \
  g++ \
  g++-multilib \
  gettext \
  git \
  gperf \
  intltool \
  libc6-dev-i386 \
  libgdk-pixbuf2.0-dev \
  libltdl-dev \
  libgl-dev \
  libpcre3-dev \
  libssl-dev \
  libtool-bin \
  libxml-parser-perl \
  lzip \
  make \
  openssl \
  p7zip-full \
  patch \
  perl \
  python3 \
  python3-distutils \
  python3-mako \
  python3-packaging \
  python3-pkg-resources \
  python3-setuptools \
  python-is-python3 \
  ruby \
  sed \
  sqlite3 \
  unzip \
  wget \
  xz-utils \ 
  mingw-w64 \
  cmake

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Set up environment
ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup
ENV PATH=/root/.cargo/bin:$PATH

# Update Rust
RUN rustup update

# Install rust toolchain version
RUN rustup default 1.86.0
RUN rustup target add x86_64-pc-windows-gnu

RUN git clone https://github.com/PirateNetwork/piratewallet-lite.git --branch master
RUN cd piratewallet-lite && ./utils/build-win.sh

RUN strip piratewallet-lite/release/piratewallet-lite.exe


FROM scratch AS binaries
COPY --from=builder piratewallet-lite/release/piratewallet-lite.exe .

