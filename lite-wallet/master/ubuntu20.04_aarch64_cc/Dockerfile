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

RUN apt-get install -y \
  gcc-aarch64-linux-gnu \
  g++-aarch64-linux-gnu

# Install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Set up environment
ENV CARGO_HOME=/root/.cargo
ENV RUSTUP_HOME=/root/.rustup
ENV PATH=/root/.cargo/bin:$PATH

# Set up cross-compilation for aarch64
RUN mkdir .cargo
RUN echo '[target.aarch64-unknown-linux-gnu]' > /.cargo/config
RUN echo 'ar = "/usr/bin/aarch64-linux-gnu-ar-9"' >> /.cargo/config
RUN echo 'linker = "/usr/bin/aarch64-linux-gnu-gcc-9"' >> /.cargo/config

# Update Rust
RUN rustup update

# Install rust toolchain version
RUN rustup default 1.86.0
RUN rustup target add aarch64-unknown-linux-gnu

#Build the project
RUN git clone https://github.com/PirateNetwork/piratewallet-lite.git --branch master
RUN cd piratewallet-lite && ./utils/build-deb-arm.sh

# Copy the artifacts to a local folder
FROM scratch AS binaries
COPY --from=builder piratewallet-lite/artifacts/* .


