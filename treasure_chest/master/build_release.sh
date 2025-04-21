#!/bin/bash -
cd ubuntu20.04
docker system df
time docker build --no-cache -o . --target=binaries .
docker buildx prune --all --force
docker system df
cd ..

cd ubuntu20.04_aarch64_cc
docker system df
time docker build --no-cache -o . --target=binaries .
docker buildx prune --all --force
docker system df
cd ..

cd ubuntu20.04_windows_cc
docker system df
time docker build --no-cache -o . --target=binaries .
docker buildx prune --all --force
docker system df
cd ..
