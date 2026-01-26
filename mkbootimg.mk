# mkbootimg.mk для SaluteTV at30a6
# Этот файл переопределяет стандартную сборку recovery-образа

# Определяем путь к утилите mkbootimg
MKBOOTIMG := $(HOST_OUT_EXECUTABLES)/mkbootimg

# Определяем компоненты для recovery-образа
INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
recovery_kernel := $(TARGET_PREBUILT_KERNEL)
recovery_ramdisk := $(call intermediates-dir-for,PACKAGING,recovery_ramdisk)/recovery_ramdisk.cpio.gz

# КРИТИЧЕСКИЙ ФИКС: Переопределяем сборку recovery-образа с заполнением до 32MB
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel)
	@echo "================================================"
	@echo "Building recovery image for at30a6 (32MB target)"
	@echo "================================================"
	
	# Создаем временный образ без заполнения
	$(hide) $(MKBOOTIMG) \
		--kernel $(recovery_kernel) \
		--ramdisk $(recovery_ramdisk) \
		$(if $(BOARD_PREBUILT_DTBIMAGE),--dt $(BOARD_PREBUILT_DTBIMAGE)) \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--header_version 2 \
		--output $(basename $@).unsigned
	
	# ЗАПОЛНЯЕМ ОБРАЗ ДО 32 МБ (33554432 байт) - КРИТИЧЕСКИ ВАЖНЫЙ ШАГ
	$(hide) truncate -s $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) $(basename $@).unsigned
	
	# Переименовываем в финальный файл
	$(hide) mv $(basename $@).unsigned $@
	
	# Проверяем размер
	$(hide) echo "Recovery image size: $$(stat -c%s $@) bytes (target: $(BOARD_RECOVERYIMAGE_PARTITION_SIZE))"
	
	@echo "Recovery image created: $@"
	@echo "================================================"

# Аналогично можно определить сборку boot-образа, если нужно
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	@echo "Building boot image for at30a6"
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo "Boot image created: $@"
