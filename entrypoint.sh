#!/bin/bash
set -ex

# Парсим аргументы
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
            echo "Неизвестный параметр: $1"
            exit 1
            ;;
    esac
done

# Проверяем обязательные переменные
if [[ -z "$MANIFEST_URL" || -z "$DEVICE_TREE_URL" ]]; then
    echo "Ошибка: MANIFEST_URL и DEVICE_TREE_URL обязательны!"
    exit 1
fi

# Устанавливаем значения по умолчанию для опциональных параметров
: ${MANIFEST_BRANCH:="twrp-11"}
: ${DEVICE_TREE_BRANCH:="main"}
: ${BUILD_TARGET:="recovery"}

echo "Настройки сборки:"
echo "MANIFEST_URL: $MANIFEST_URL"
echo "MANIFEST_BRANCH: $MANIFEST_BRANCH"
echo "DEVICE_TREE_URL: $DEVICE_TREE_URL"
echo "DEVICE_TREE_BRANCH: $DEVICE_TREE_BRANCH"
echo "DEVICE_PATH: $DEVICE_PATH"
echo "DEVICE_NAME: $DEVICE_NAME"
echo "MAKEFILE_NAME: $MAKEFILE_NAME"
echo "BUILD_TARGET: $BUILD_TARGET"

# Перемещаемся в рабочую директорию
cd /workspace

# Устанавливаем Repo tool
mkdir -p bin
curl -s https://storage.googleapis.com/git-repo-downloads/repo > bin/repo
chmod a+x bin/repo
ln -sf bin/repo /usr/bin/repo || true

# Инициализируем и синхронизируем репозиторий
repo init -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH" --depth=1
repo sync -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Клонируем дерево устройства
if [[ ! -d "$DEVICE_PATH" ]]; then
    git clone "$DEVICE_TREE_URL" -b "$DEVICE_TREE_BRANCH" "$DEVICE_PATH"
fi

# Очищаем и конфигурируем среду
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_DIR="/tmp/ccache"
lunch "${MAKEFILE_NAME}"-eng

# Собираем образ
make clean
make "${BUILD_TARGET}"image -j$(nproc --all)

# Архивируем полученный образ
if [[ -f "out/target/product/$DEVICE_NAME/${BUILD_TARGET}.img" ]]; then
    cd out/target/product/"$DEVICE_NAME"
    ls -lh "${BUILD_TARGET}.img"
    gzip -k "${BUILD_TARGET}.img"
    echo "Сборка выполнена успешно!"
    
    # Копируем в выходную директорию
    mkdir -p /workspace/out
    cp "${BUILD_TARGET}.img.gz" /workspace/out/
else
    echo "Ошибка: файл ${BUILD_TARGET}.img не найден!"
    ls -la out/target/product/"$DEVICE_NAME"/
    exit 1
fi

exit 0
