# device/salute/at30a6/device.mk

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

PRODUCT_DEVICE := at30a6
PRODUCT_NAME := at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV
PRODUCT_MANUFACTURER := SaluteTV

PRODUCT_PACKAGES += \
    tune2fs \
    mke2fs

# ====================================================
# КОПИРОВАНИЕ ФАЙЛОВ
# ====================================================

# Корень
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/ueventd.rc:recovery/root/ueventd.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.amlogic.rc:recovery/root/init.recovery.amlogic.rc \
    $(LOCAL_PATH)/recovery/root/adb_keys:recovery/root/adb_keys

# FSTAB
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/system/etc/recovery.fstab:recovery/root/system/etc/recovery.fstab

# sbin
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/sbin/adbd:recovery/root/sbin/adbd \
    $(LOCAL_PATH)/recovery/root/sbin/adbd_binary:recovery/root/sbin/adbd_binary \
    $(LOCAL_PATH)/recovery/root/sbin/busybox:recovery/root/sbin/busybox \
    $(LOCAL_PATH)/recovery/root/sbin/sh:recovery/root/sbin/sh \
    $(LOCAL_PATH)/recovery/root/sbin/mesondisplay.cfg:recovery/root/sbin/mesondisplay.cfg \
    $(LOCAL_PATH)/recovery/root/sbin/recovery.kl:recovery/root/sbin/recovery.kl \
    $(LOCAL_PATH)/recovery/root/sbin/remote_nec.cfg:recovery/root/sbin/remote_nec.cfg \
    $(LOCAL_PATH)/recovery/root/sbin/remote_nec_ircus1.tab:recovery/root/sbin/remote_nec_ircus1.tab \
    $(LOCAL_PATH)/recovery/root/sbin/remote_nec_ircus2.tab:recovery/root/sbin/remote_nec_ircus2.tab \
    $(LOCAL_PATH)/recovery/root/sbin/remote_nec_irfac.tab:recovery/root/sbin/remote_nec_irfac.tab
