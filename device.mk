# device.mk for SaluteTV at30a6

# Inherit from common
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)

# Inherit from TWRP
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

# Device identifier
PRODUCT_DEVICE := at30a6
PRODUCT_NAME := twrp_at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV
PRODUCT_MANUFACTURER := SaluteTV

# Properties
PRODUCT_PROPERTY_OVERRIDES := \
    ro.build.product=at30a6 \
    ro.twrp.device=at30a6