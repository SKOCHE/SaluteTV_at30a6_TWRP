# twrp_at30a6.mk for Android 13

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# Определяем имя устройства для сборки
PRODUCT_DEVICE := at30a6
PRODUCT_NAME := twrp_at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := at30a6 TWRP
PRODUCT_MANUFACTURER := SaluteTV
