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
    dos2unix \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /workspace

COPY entrypoint.sh /entrypoint.sh

RUN dos2unix /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    echo "=== ПРОВЕРКА ФАЙЛА ===" && \
    ls -la /entrypoint.sh && \
    echo "Первые 3 байта (должны быть #!):" && \
    od -c /entrypoint.sh | head -2

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
