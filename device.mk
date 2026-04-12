$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

PRODUCT_DEVICE := at30a6
PRODUCT_NAME := at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV
PRODUCT_MANUFACTURER := SaluteTV

PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd \
    tune2fs \
    mke2fs \
    -libbinder_ndk


PRODUCT_HOST_PACKAGES += \
    libadbconnection_client \
    libadb_pairing_auth \
    libadb_pairing_connection \
    libadb_pairing_server
