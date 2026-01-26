# BoardConfig.mk for SaluteTV at30a6 - FINAL WORKING VERSION

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

# CRITICAL FIXES FOR BUILD ERRORS
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_ENFORCE_SYSPROP_OWNER := true
BUILD_BROKEN_DUP_SYSPROP := true

# Fix linker errors (ld.lld issues)
USE_LD := gold
TARGET_LD_SHIM_LIBS := /system/bin/linker:/system/bin/linker64

# Disable problematic checks
TARGET_NO_KERNEL := false
TARGET_NO_KERNEL_OVERRIDE := false

# Kernel
TARGET_PREBUILT_KERNEL := device/salute/at30a6/prebuilt/kernel
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_HEADER_ARCH := arm
TARGET_KERNEL_CROSS_COMPILE_PREFIX := arm-linux-androideabi-

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x00000100

# Board name for mkbootimg
BOARD_NAME := at30a6

# Output files
TARGET_RECOVERY_IMAGE_NAME := recovery.img
PRODUCT_OUT := out/target/product/at30a6

# Kernel cmdline
BOARD_KERNEL_CMDLINE := androidboot.selinux=permissive
BOARD_KERNEL_IMAGE_NAME := zImage

# DTB settings - FIXED: Uses dt.img correctly
BOARD_PREBUILT_DTBIMAGE_DIR := device/salute/at30a6/prebuilt
BOARD_PREBUILT_DTBIMAGE := device/salute/at30a6/prebuilt/dt.img
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# DTBO
BOARD_INCLUDE_RECOVERY_DTBO := true
BOARD_PREBUILT_DTBOIMAGE := device/salute/at30a6/prebuilt/dtbo.img

# Partitions - MUST BE 32MB for recovery
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864        # 64 MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432    # 32 MB
BOARD_DTBOIMG_PARTITION_SIZE := 2097152           # 2 MB

# Filesystem
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

# System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
BOARD_SUPPRESS_SECURE_ERASE := true

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
TW_NO_EXFAT_FUSE := true

# Brightness
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 128
TW_BRIGHTNESS_PATH := "/sys/class/backlight/backlight/brightness"

# Crypto - DISABLED
TW_INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO_FBE := false
TW_INCLUDE_FBE_METADATA_DECRYPT := false
BOARD_USES_METADATA_PARTITION := false

# Storage
TW_HAS_NO_RECOVERY_PARTITION := true
TW_NO_USB_STORAGE := false
TW_INTERNAL_STORAGE_PATH := "/data/media/0"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/external_sd"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "external_sd"
TW_DEFAULT_EXTERNAL_STORAGE := true
RECOVERY_SDCARD_ON_DATA := true

# Custom mkbootimg - ENABLED
BOARD_CUSTOM_BOOTIMG_MK := device/salute/at30a6/mkbootimg.mk

# mkbootimg arguments - SIMPLE VERSION (no --dt here)
BOARD_MKBOOTIMG_ARGS := --pagesize $(BOARD_KERNEL_PAGESIZE) \
                        --kernel_offset $(BOARD_KERNEL_OFFSET) \
                        --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
                        --tags_offset $(BOARD_TAGS_OFFSET) \
                        --header_version 2

# Device specific
TW_DEVICE_VERSION := SaluteTV_at30a6_$(shell date +%Y%m%d)
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID := true

# Fix for Android 11/12
PLATFORM_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 11

# Allow missing dependencies
ALLOW_MISSING_DEPENDENCIES := true

# Board info
PRODUCT_PLATFORM := amlogic
TARGET_BOARD_INFO_FILE := device/salute/at30a6/board-info.txt

# Flash block size
BOARD_FLASH_BLOCK_SIZE := 131072

# Graphics
TARGET_RECOVERY_OVERSCAN_PERCENT := 10
TW_NO_SCREEN_BLANK := true
TW_NO_SCREEN_TIMEOUT := true
