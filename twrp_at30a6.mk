# twrp_at30a6.mk for Android 13

# Inherit from TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit device configuration
$(call inherit-product, device/salute/at30a6/device.mk)

# Device identifier
PRODUCT_DEVICE := at30a6
PRODUCT_NAME := twrp_at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV
PRODUCT_MANUFACTURER := SaluteTV

# TWRP Configuration
PRODUCT_PACKAGES += \
    twrpdecrypt

# Set build fingerprint / ID
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="at30a6-user 13 TP1A.220905.004.A2 eng.jenkin.20251004.165826 release-keys"

BUILD_FINGERPRINT := SaluteTV/at30a6/at30a6:13/TP1A.220905.004.A2/jenkins10041657:user/release-keys