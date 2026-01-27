#!/bin/bash
set -ex

# Перемещаемся в рабочую директорию
cd /workspace

# Устанавливаем Repo tool
mkdir bin
curl https://storage.googleapis.com/git-repo-downloads/repo > bin/repo
chmod a+x bin/repo
ln -sf bin/repo /usr/bin/repo

# Инициализируем и синхронизируем репозиторий
repo init -u "$MANIFEST_URL" -b "$MANIFEST_BRANCH" --depth=1
repo sync -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Клиним устройство дерево
git clone "$DEVICE_TREE_URL" -b "$DEVICE_TREE_BRANCH" "$DEVICE_PATH"

# Очищаем и конфигурируем среду
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export LC_ALL=C
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_DIR="/tmp/ccache"
lunch "$MAKEFILE_NAME"-eng

# Собираем образ
make clean
make "$BUILD_TARGET"image -j$(nproc --all)

# Архивируем полученный образ
cd out/target/product/"$DEVICE_NAME"
ls -lh "$BUILD_TARGET.img"
gzip -k "$BUILD_TARGET.img"

echo "Сборка выполнена успешно!"
exit 0