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

# ДЕБАГ: показываем, что копируем
COPY entrypoint.sh /entrypoint.sh
RUN echo "=== ДЕБАГ В DOCKERFILE ===" && \
    echo "Файл скопирован?" && \
    ls -la /entrypoint.sh && \
    echo "Первые 5 строк:" && \
    head -5 /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    echo "Права:" && \
    ls -la /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
