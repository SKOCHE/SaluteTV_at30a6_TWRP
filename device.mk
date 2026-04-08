$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

PRODUCT_DEVICE := at30a6
PRODUCT_NAME := at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV
PRODUCT_MANUFACTURER := SaluteTV

PRODUCT_PACKAGES += \
    tune2fs \
    mke2fs 

PRODUCT_HOST_PACKAGES += \
    libadbconnection_client \
    libadb_pairing_auth \
    libadb_pairing_connection \
    libadb_pairing_server

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.amlogic.rc:recovery/init.recovery.amlogic.rc \
    $(LOCAL_PATH)/recovery/root/prop.default:recovery/prop.default \
    $(LOCAL_PATH)/recovery/root/usr/keylayout/Generic.kl:usr/keylayout/Generic.kl \
    $(LOCAL_PATH)/recovery/root/usr/keylayout/qwerty.kl:usr/keylayout/qwerty.kl \
    $(LOCAL_PATH)/recovery/root/usr/idc/Generic.idc:usr/idc/Generic.idc
