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

# Установим dos2unix для конвертации концов строк
RUN apt-get update && apt-get install -y dos2unix && apt-get clean

WORKDIR /workspace

# Копируем entrypoint.sh и исправляем концы строк
COPY entrypoint.sh /entrypoint.sh
RUN dos2unix /entrypoint.sh && \
    chmod 755 /entrypoint.sh && \
    echo "=== ПРОВЕРКА ФАЙЛА ===" && \
    ls -la /entrypoint.sh && \
    file /entrypoint.sh && \
    echo "=== ПЕРВЫЕ 10 СТРОК ===" && \
    head -10 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
