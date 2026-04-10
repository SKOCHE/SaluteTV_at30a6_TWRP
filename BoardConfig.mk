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
TARGET_BOARD_PLATFORM_GPU := mali-450
TARGET_BOOTLOADER_BOARD_NAME := at30a6
TARGET_NO_BOOTLOADER := true
TARGET_USES_TV := true

# Разрешить ошибки
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
RELAX_USES_LIBRARY_CHECK := true
# Ядро
TARGET_PREBUILT_KERNEL := device/salute/at30a6/prebuilt/kernel
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_HEADER_ARCH := arm
BOARD_KERNEL_IMAGE_NAME := uImage
TARGET_KERNEL_FORMAT := uImage

# Параметры образа
BOARD_KERNEL_BASE := 0x00108000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_SECOND_OFFSET := 0x00f00000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x0
BOARD_NAME := at30a6
BOARD_BOOTIMG_HEADER_VERSION := 4

# Командная строка
BOARD_KERNEL_CMDLINE := androidboot.dynamic_partitions=true androidboot.dynamic_partitions_retrofit=true androidboot.dtbo_idx=0 androidboot.boot_devices=soc/ffe07000.mmc use_uvm=1 printk.devkmsg=on buildvariant=user androidboot.selinux=permissive

BOARD_MKBOOTIMG_ARGS := \
    --pagesize $(BOARD_KERNEL_PAGESIZE) \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --second_offset $(BOARD_SECOND_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET) \
    --header_version $(BOARD_BOOTIMG_HEADER_VERSION) \
    --board "$(BOARD_NAME)" \
    --os_version 13.0.0 \
    --os_patch_level 2022-09 \
    --cmdline "$(BOARD_KERNEL_CMDLINE)"

# Разделы
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33554432
BOARD_FLASH_BLOCK_SIZE := 4096

# Динамические разделы
BOARD_SUPER_PARTITION_SIZE := 4294967296
BOARD_SUPER_PARTITION_GROUPS := amlogic_dynamic_partitions
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_SIZE := 4290822144
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product system_ext odm vendor_dlkm 

# Файловые системы
BOARD_HAS_LARGE_FILESYSTEM := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Пути для копирования разделов
TARGET_COPY_OUT_VENDOR := vendor
TARGET_COPY_OUT_PRODUCT := product
TARGET_COPY_OUT_SYSTEM_EXT := system_ext
TARGET_COPY_OUT_ODM := odm
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
TARGET_COPY_OUT_SYSTEM_DLKM := system
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm

# Типы файловых систем разделов
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := ext4

# Сжатие ramdisk
BOARD_RAMDISK_USE_LZ4 := true
LZ4_RAMDISK := true

# ====================================================
# TWRP НАСТРОЙКИ
# ====================================================
BOARD_SUPPRESS_SECURE_ERASE := true
TW_HAS_MTP := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
# FSTAB
TARGET_RECOVERY_FSTAB := device/salute/at30a6/recovery/root/system/etc/recovery.fstab

# ====================================================
# ГРАФИКА
# ====================================================
TW_RECOVERY_GRAPHICS := amlogic
TARGET_RECOVERY_FORCE_PIXEL_FORMAT := "RGB_565"
TW_SCREEN_WIDTH := 1920
TW_SCREEN_HEIGHT := 1080
TW_DPI := 320
TW_THEME := landscape_hdpi
TW_BRIGHTNESS_PATH := /sys/class/backlight/backlight/brightness
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1200
TW_USE_LIBINPUT := true

# Флаги совместимости
TW_NO_EXFAT := false
TW_NO_EXFAT_FUSE := true
TW_IGNORE_MISC_WIPE_DATA := true

# ====================================================
# SUPER-РАЗДЕЛЫ (КЛЮЧЕВЫЕ ФЛАГИ)
# ====================================================
TW_INCLUDE_SUPER := true
TW_INCLUDE_LPTOOLS := true
TW_INCLUDE_LPDUMP := true
TW_INCLUDE_RESETPROP := true
TW_INCLUDE_LIBRESETPROP :=true
TW_INCLUDE_FASTBOOTD := true
TW_INCLUDE_FASTBOOT := true
TW_EXCLUDE_ADBD := true
# ====================================================
# ОПТИМИЗАЦИЯ РАЗМЕРА
# ====================================================
TW_NO_LEGACY_PROPS := true
RECOVERY_BUSYBOX_BINARY := true
TARGET_RECOVERY_BUSYBOX_BINARY := true
TW_INCLUDE_BUSYBOX := true
TW_USE_TOOLBOX := false
TW_NO_CRYPTO := true

# Android Verified Boot
BOARD_AVB_ENABLE := false

# Язык
TW_DEFAULT_LANGUAGE := ru
TW_NO_SCREEN_TIMEOUT := true
TW_NO_SCREEN_BLANK := false

# Отключение лишнего для уменьшения размера
TW_EXCLUDE_TWRPAPP := true
TW_EXCLUDE_SUPERSU := true
TW_EXCLUDE_MAGISK := true
TW_EXCLUDE_BASH := true
TW_EXCLUDE_NANO := true
TW_EXCLUDE_VIM := true
TW_EXCLUDE_APEX := true
TW_EXTRA_LANGUAGES := false
TW_INCLUDE_REPACKTOOLS := false
TW_NO_BOOT_BOOTLOADER := true
TW_NO_REBOOT_BOOTLOADER := true
TW_INCLUDE_USB_OTG := true
# Принудительное монтирование tmp с exec
TW_EXEC_TMP_MOUNT := true
TW_DEVICE_VERSION := at30a6 by SK

