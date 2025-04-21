FROM ubuntu:20.04 AS builder
ENV DEBIAN_FRONTEND=interactive

# Install dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  build-essential \
  cmake \
  pkg-config \
  python3 \
  git \
  gperf \
  curl \
  bison



# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Set up environment
ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup
ENV PATH=/root/.cargo/bin:$PATH

# Update Rust
RUN rustup update

# Install rust toolchain version
RUN rustup default 1.58.1

RUN git clone https://github.com/PirateNetwork/piratewallet-lite.git --branch master
RUN cd piratewallet-lite && ./utils/build-deb.sh

RUN strip piratewallet-lite/piratewallet-lite


FROM scratch AS binaries
COPY --from=builder piratewallet-lite/piratewallet-lite .

