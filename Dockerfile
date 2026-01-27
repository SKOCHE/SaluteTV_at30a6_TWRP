FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    gperf \
    build-essential \
    gcc-multilib \
    g++-multilib \
    lib32z-dev \
    lib32ncurses5-dev \
    libxml2-utils \
    xsltproc \
    bc \
    ccache \
    liblz4-tool \
    libncurses5-dev \
    lzop \
    imagemagick \
    libbz2-dev \
    python3 \
    curl \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    openjdk-8-jdk \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /workspace

# Создаем entrypoint.sh прямо в образе
RUN echo '#!/bin/bash
set -ex

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --manifest-url=*)
            MANIFEST_URL="${1#*=}"
            shift
            ;;
        --manifest-branch=*)
            MANIFEST_BRANCH="${1#*=}"
            shift
            ;;
        --device-tree-url=*)
            DEVICE_TREE_URL="${1#*=}"
            shift
            ;;
        --device-tree-branch=*)
            DEVICE_TREE_BRANCH="${1#*=}"
            shift
            ;;
        --device-path=*)
            DEVICE_PATH="${1#*=}"
            shift
            ;;
        --device-name=*)
            DEVICE_NAME="${1#*=}"
            shift
            ;;
        --makefile-name=*)
            MAKEFILE_NAME="${1#*=}"
            shift
            ;;
        --build-target=*)
            BUILD_TARGET="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

# Check required variables
if [[ -z "$MANIFEST_URL" || -z "$DEVICE_TREE_URL" ]]; then
    echo "Error: MANIFEST_URL and DEVICE_TREE_URL are required!"
    exit 1
fi

# Set defaults
: ${MANIFEST_BRANCH:="twrp-11"}
: ${DEVICE_TREE_BRANCH:="main"}
: ${BUILD_TARGET:="recovery"}

echo "Build settings:"
echo "MANIFEST_URL: $MANIFEST_URL"
echo "MANIFEST_BRANCH: $MANIFEST_BRANCH"
echo "DEVICE_TREE_URL: $DEVICE_TREE_URL"
echo "DEVICE_TREE_BRANCH: $DEVICE_TREE_BRANCH"
echo "DEVICE_PATH: $DEVICE_PATH"
echo "DEVICE_NAME: $DEVICE_NAME"
echo "MAKEFILE_NAME: $MAKEFILE_NAME"
echo "BUILD_TARGET: $BUILD_TARGET"

# Change to workspace
cd /workspace

# Install Repo tool
mkdir -p bin
curl -s https://storage.googleapis.com/git-repo-downloads/repo > bin/repo
chmod a+x bin/repo
ln -sf bin/repo /usr/bin/repo || true

# Initialize and sync repository
repo init -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH" --depth=1
repo sync -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Clone device tree
if [[ ! -d "$DEVICE_PATH" ]]; then
    git clone "$DEVICE_TREE_URL" -b "$DEVICE_TREE_BRANCH" "$DEVICE_PATH"
fi

# Setup environment
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_DIR="/tmp/ccache"
lunch "${MAKEFILE_NAME}"-eng

# Build
make clean
make "${BUILD_TARGET}"image -j$(nproc --all)

# Archive output
if [[ -f "out/target/product/$DEVICE_NAME/${BUILD_TARGET}.img" ]]; then
    cd out/target/product/"$DEVICE_NAME"
    ls -lh "${BUILD_TARGET}.img"
    gzip -k "${BUILD_TARGET}.img"
    echo "Build successful!"
    
    # Copy to output directory
    mkdir -p /workspace/out
    cp "${BUILD_TARGET}.img.gz" /workspace/out/
else
    echo "Error: ${BUILD_TARGET}.img not found!"
    ls -la out/target/product/"$DEVICE_NAME"/
    exit 1
fi

exit 0' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
