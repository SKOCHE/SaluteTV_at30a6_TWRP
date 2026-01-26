# Наследуем конфигурацию TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

# Определяем устройство
PRODUCT_DEVICE := at30a6
PRODUCT_NAME := twrp_at30a6
PRODUCT_BRAND := SaluteTV
PRODUCT_MODEL := at30a6 TWRP
PRODUCT_MANUFACTURER := SaluteTV

# Копируем предсобранные файлы в выходной каталог
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/prebuilt/kernel:kernel \
    $(LOCAL_PATH)/prebuilt/dt.img:dtb
