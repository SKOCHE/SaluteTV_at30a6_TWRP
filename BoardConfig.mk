# BoardConfig.mk for SaluteTV (at30a6)

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := cortex-a7
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true

# Bootloader
TARGET_NO_BOOTLOADER := true
TARGET_BOOTLOADER_BOARD_NAME := at30a6

# Platform
TARGET_BOARD_PLATFORM := amlogic

# Kernel
TARGET_PREBUILT_KERNEL := device/salute/at30a6/prebuilt/kernel
BOARD_KERNEL_BASE := 0x0
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage

# DTB для Amlogic - ИСПРАВЛЕНО!
BOARD_PREBUILT_DTBIMAGE_DIR := device/salute/at30a6/prebuilt
BOARD_MKBOOTIMG_ARGS := --dt $(BOARD_PREBUILT_DTBIMAGE_DIR)/dt.img

# Recovery init files
TARGET_RECOVERY_ROOT_OUT := $(LOCAL_PATH)/recovery/root

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864        # 64 MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432    # 32 MB
BOARD_DTBOIMG_PARTITION_SIZE := 2097152           # 2 MB

# DTBO
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := device/salute/at30a6/prebuilt/dtbo.img

# Для Amlogic
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs  # ИЛИ ext4, проверьте на устройстве

# Recovery
TARGET_RECOVERY_FSTAB := device/salute/at30a6/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 120

# TWRP Configuration
TW_THEME := portrait_hdpi
TW_EXTRA_LANGUAGES := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_USE_TOOLBOX := true
TW_INCLUDE_REPACKTOOLS := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP := true
TW_EXCLUDE_DEFAULT_USB_INIT := true

# Brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 128
TW_BRIGHTNESS_PATH := "/sys/class/backlight/backlight/brightness"

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
BOARD_USES_METADATA_PARTITION := true

# Storage
TW_HAS_NO_RECOVERY_PARTITION := true
TW_NO_USB_STORAGE := false
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true

# Device specific
TW_DEVICE_VERSION := SaluteTV_1.100.61
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# Для Amlogic устройств с dt.img
BOARD_CUSTOM_BOOTIMG_MK := device/salute/at30a6/mkbootimg.mk

# Для включения DTBO в boot/recovery
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Размер блока флеш-памяти
BOARD_FLASH_BLOCK_SIZE := 131072