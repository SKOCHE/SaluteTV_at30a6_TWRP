# twrp_at30a6.mk for Android 13

$(call inherit-product, $(SRC_TARGET_DIR)/product/generic.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_DEVICE := at30a6
PRODUCT_NAME := twrp_at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := SaluteTV at30a6
PRODUCT_MANUFACTURER := SaluteTV

# Критически важный флаг для пропуска проверок зависимостей
PRODUCT_BUILD_SUPPORT_ANY_OTA_IMAGE := true

