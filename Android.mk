LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

# Только самая базовая информация
LOCAL_MODULE := at30a6_recovery
LOCAL_MODULE_TAGS := optional

include $(BUILD_PHONY_PACKAGE)