#!/bin/bash -
set -eu -o pipefail
cd "$(dirname "$0")"

# All three ubuntu20.04-based builds (native, aarch64 cross, Windows cross)
# share one output folder - the filenames `docker build`'s `binaries` stage
# produces already encode platform/arch/version (see zcutil/build-deb.sh,
# zcutil/build-zip.sh in the main pirate repo), so they can't collide within
# a folder.
OUT_2004="$(pwd)/ubuntu2004"
rm -rf "$OUT_2004"
mkdir -p "$OUT_2004"

for dir in ubuntu20.04 ubuntu20.04_aarch64_cc ubuntu20.04_windows_cc; do
    cd "$dir"
    docker system df
    time docker build --no-cache -o "$OUT_2004" --target=binaries .
    docker buildx prune --all --force
    docker system df
    cd ..
done
