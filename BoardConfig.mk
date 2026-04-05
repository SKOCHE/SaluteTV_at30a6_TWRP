# BoardConfig.mk - SaluteTV at30a6 (TWRP)

TARGET_DEVICE := at30a6

# Архитектура
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true

# Платформа
TARGET_BOARD_PLATFORM := amlogic
TARGET_BOOTLOADER_BOARD_NAME := at30a6
TARGET_NO_BOOTLOADER := true
TARGET_USES_TV := true

# Разрешить ошибки
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true

# Ядро
TARGET_PREBUILT_KERNEL := device/salute/at30a6/prebuilt/kernel
TARGET_KERNEL_ARCH := arm
BOARD_KERNEL_IMAGE_NAME := uImage
TARGET_KERNEL_FORMAT := uImage

# Параметры образа
BOARD_KERNEL_BASE := 0x00108000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_BOOTIMG_HEADER_VERSION := 4

# Командная строка
BOARD_KERNEL_CMDLINE := androidboot.dynamic_partitions=true androidboot.dynamic_partitions_retrofit=true androidboot.dtbo_idx=0 androidboot.boot_devices=soc/ffe07000.mmc use_uvm=1 printk.devkmsg=on buildvariant=user fb.scale=50

BOARD_MKBOOTIMG_ARGS := \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --header_version $(BOARD_BOOTIMG_HEADER_VERSION)

# Разделы
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 4096

# FSTAB
TARGET_RECOVERY_FSTAB := device/salute/at30a6/recovery/root/system/etc/recovery.fstab

# ====================================================
# ГРАФИКА
# ====================================================
TW_RECOVERY_GRAPHICS := amlogic
TW_RECOVERY_PIXEL_FORMAT := BGRA_8888
TW_SCREEN_WIDTH := 1920
TW_SCREEN_HEIGHT := 1080
TW_DPI := 240
TW_THEME := landscape_hdpi

# ====================================================
# TWRP НАСТРОЙКИ (минимум)
# ====================================================
TW_DEFAULT_LANGUAGE := ru
TW_BRIGHTNESS_PATH := /sys/class/backlight/backlight/brightness
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200

# Отключение лишнего для уменьшения размера
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_MAGISK := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_VIM := true
TW_EXTRA_LANGUAGES := false
TW_INCLUDE_REPACKTOOLS := false

# Аппаратная специфика
BOARD_AMLOGIC_HARDWARE_RECOVERY := true
