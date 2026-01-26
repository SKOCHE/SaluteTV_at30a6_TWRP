# ============================================================
# BoardConfig.mk - SaluteTV at30a6 (Amlogic platform) - ARM32
# Полная версия для сборки TWRP через AOSP build system
# ============================================================

# ------------------------------------------------------------
# Архитектура процессора (Amlogic S905X?/S905Y? - ARM 32-bit)
# ------------------------------------------------------------
# ВАЖНО: Устройство 32-bit ARMv7
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true

# ------------------------------------------------------------
# Платформа и загрузчик
# ------------------------------------------------------------
TARGET_BOARD_PLATFORM := amlogic
TARGET_BOARD_PLATFORM_GPU := mali-450
TARGET_BOOTLOADER_BOARD_NAME := at30a6
TARGET_NO_BOOTLOADER := true

# ------------------------------------------------------------
# КРИТИЧЕСКИЕ ФИКСЫ ДЛЯ СБОРКИ TWRP/AOSP
# ------------------------------------------------------------
# Разрешаем пропуск зависимостей
ALLOW_MISSING_DEPENDENCIES := true

# Отключаем проблемные проверки
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_DUP_SYSPROP := true

# Отключаем LTO и другие проблемные оптимизации
BUILD_BROKEN_CLANG_ASFLAGS := true
BUILD_BROKEN_CLANG_CFLAGS := true

# ------------------------------------------------------------
# НАСТРОЙКИ ЯДРА (используем предсобранное ядро)
# ------------------------------------------------------------
TARGET_PREBUILT_KERNEL := device/salute/at30a6/prebuilt/kernel
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_HEADER_ARCH := arm
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-
BOARD_KERNEL_IMAGE_NAME := zImage

# ------------------------------------------------------------
# ПАРАМЕТРЫ BOOT/RECOVERY ОБРАЗА - ARM32 СМЕЩЕНИЯ
# ------------------------------------------------------------
# КРИТИЧЕСКАЯ ПРАВКА: Для ARM32 используем правильные адреса
BOARD_KERNEL_BASE := 0x80000000        # Стандарт для ARM32
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x0

# Название платы для mkbootimg
BOARD_NAME := at30a6

# Командная строка ядра (из AIK - "30a6")
BOARD_KERNEL_CMDLINE := console=ttyS0,115200n8 androidboot.selinux=permissive 30a6

# Версия заголовка bootimg
BOARD_HEADER_VERSION := 0
BOARD_BOOTIMG_HEADER_VERSION := 0

# ------------------------------------------------------------
# DTB/DTBO КОНФИГУРАЦИЯ
# ------------------------------------------------------------
BOARD_PREBUILT_DTBIMAGE_DIR := device/salute/at30a6/prebuilt
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# DTBO (если есть)
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := device/salute/at30a6/prebuilt/dtbo.img
BOARD_DTBOIMG_PARTITION_SIZE := 8388608  # 8MB

# ------------------------------------------------------------
# РАЗМЕРЫ РАЗДЕЛОВ (CRITICAL - должны совпадать с прошивкой)
# ------------------------------------------------------------
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864        # 64MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432    # 32MB для recovery
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2147483648    # 2GB
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12884901888 # 12GB
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456      # 256MB
BOARD_FLASH_BLOCK_SIZE := 4096                    # Для eMMC

# ============================================================
# КРИТИЧЕСКИЕ ПРАВКИ ДЛЯ VENDOR РАЗДЕЛА (исправление ошибки)
# ============================================================
# ВАЖНО: Эти строки исправляют ошибку "TARGET_COPY_OUT_VENDOR must be set to 'vendor'"
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 268435456      # 256MB

# Определяем, что устройство имеет vendor раздел
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor  # Явное определение

# ============================================================

# ------------------------------------------------------------
# ФАЙЛОВЫЕ СИСТЕМЫ
# ------------------------------------------------------------
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# System-as-root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
AB_OTA_UPDATER := false

# ------------------------------------------------------------
# НАСТРОЙКИ ВОССТАНОВЛЕНИЯ (RECOVERY)
# ------------------------------------------------------------
TARGET_RECOVERY_FSTAB := device/salute/at30a6/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 120
TARGET_RECOVERY_UI_MARGIN_WIDTH := 60

# Вывод информации о сборке
TARGET_RECOVERY_DEVICE_MODULES := \
    debuggerd \
    strace \
    toybox

# ------------------------------------------------------------
# TWRP СПЕЦИФИЧНЫЕ НАСТРОЙКИ
# ------------------------------------------------------------
# Тема и язык
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_DEFAULT_LANGUAGE := ru

# Экран
TW_SCREEN_BLANK_ON_BOOT := true
TW_BRIGHTNESS_PATH := /sys/class/backlight/backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 128
TW_NO_SCREEN_BLANK := false
TW_NO_SCREEN_TIMEOUT := false

# Ввод
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_KEY_CODE_TOUCH_SYNC := 0

# Инструменты
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_EXCLUDE_DEFAULT_USB_INIT := true

# Шифрование (ОТКЛЮЧЕНО для упрощения)
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
TW_INCLUDE_FBE_METADATA_DECRYPT := false
BOARD_USES_METADATA_PARTITION := false

# Хранилище
TW_HAS_NO_RECOVERY_PARTITION := true
TW_NO_USB_STORAGE := false
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
RECOVERY_SDCARD_ON_DATA := true

# Файловые системы
TW_NO_EXFAT := true
TW_NO_EXFAT_FUSE := true
TW_NO_BIND_SYSTEM := true

# Дополнительно
TW_DEVICE_VERSION := SaluteTV_at30a6_TWRP_3.7.0
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# ------------------------------------------------------------
# ВЕРСИИ ПЛАТФОРМЫ И БЕЗОПАСНОСТИ
# ------------------------------------------------------------
PLATFORM_VERSION := 13
PLATFORM_VERSION_LAST_STABLE := 13
PLATFORM_SECURITY_PATCH := 2024-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# ------------------------------------------------------------
# ПРОЧИЕ НАСТРОЙКИ
# ------------------------------------------------------------
# Графика
TARGET_RECOVERY_OVERSCAN_PERCENT := 10
TARGET_USES_MEDIA_EXTENSIONS := true

# Линкер (фикс для сборки)
USE_LD := gold
TARGET_LD_SHIM_LIBS := /system/bin/linker

# Информация о плате
PRODUCT_PLATFORM := amlogic
TARGET_BOARD_INFO_FILE := device/salute/at30a6/board-info.txt

# USB
TARGET_USE_CUSTOM_LUN_FILE_PATH := /config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file

# Отладка
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true

# OTA
TARGET_NO_RECOVERY := false
TARGET_RECOVERY_UPDATER_LIBS := librecovery_updater_at30a6
TARGET_RECOVERY_UI_LIB := librecovery_ui_at30a6

# ------------------------------------------------------------
# MKBOOTIMG АРГУМЕНТЫ (для сборки образа)
# ------------------------------------------------------------
BOARD_MKBOOTIMG_ARGS := \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --base $(BOARD_KERNEL_BASE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET) \
    --header_version $(BOARD_BOOTIMG_HEADER_VERSION) \
    --cmdline "$(BOARD_KERNEL_CMDLINE)" \
    --board "$(BOARD_NAME)"

# Использование кастомного mkbootimg (опционально)
BOARD_CUSTOM_BOOTIMG_MK := device/salute/at30a6/mkbootimg.mk

# ------------------------------------------------------------
# ФИНАЛЬНЫЕ ОПРЕДЕЛЕНИЯ
# ------------------------------------------------------------
# Гарантируем, что сборка пойдет
TARGET_NO_KERNEL := false
TARGET_NO_KERNEL_OVERRIDE := false
BOARD_VENDOR_KERNEL_MODULES :=

# Указываем, что это устройство TV
TARGET_USES_TV := true
TARGET_SUPPORTS_ANDROID_TV := true
