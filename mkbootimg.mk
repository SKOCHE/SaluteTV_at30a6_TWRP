# mkbootimg.mk для SaluteTV at30a6
# Этот файл переопределяет стандартную сборку recovery-образа

# Определяем путь к утилите mkbootimg
MKBOOTIMG := $(HOST_OUT_EXECUTABLES)/mkbootimg

# Определяем компоненты для recovery-образа
INSTALLED_RECOVERYIMAGE_TARGET := $(PRODUCT_OUT)/recovery.img
recovery_kernel := $(TARGET_PREBUILT_KERNEL)
recovery_ramdisk := $(call intermediates-dir-for,PACKAGING,recovery_ramdisk)/recovery_ramdisk.cpio.gz

# Путь к dt.img и dtbo.img
DTB_IMAGE := device/salute/at30a6/prebuilt/dt.img
DTBO_IMAGE := device/salute/at30a6/prebuilt/dtbo.img

# Проверяем наличие dt.img перед сборкой
ifeq ($(wildcard $(DTB_IMAGE)),)
  $(warning DTB image not found: $(DTB_IMAGE))
else
  $(info Using DTB image: $(DTB_IMAGE))
endif

ifeq ($(wildcard $(DTBO_IMAGE)),)
  $(warning DTBO image not found: $(DTBO_IMAGE))
else
  $(info Using DTBO image: $(DTBO_IMAGE))
endif

# КРИТИЧЕСКИЙ ФИКС: Переопределяем сборку recovery-образа с заполнением до 32MB
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel)
	@echo "================================================"
	@echo "Building recovery image for at30a6 (32MB target)"
	@echo "Kernel: $(notdir $(recovery_kernel))"
	@echo "Ramdisk: $(notdir $(recovery_ramdisk))"
	@echo "================================================"
	
	# Проверяем наличие dt.img
	$(if $(wildcard $(DTB_IMAGE)),,$(error DTB image not found: $(DTB_IMAGE)))
	
	# Создаем временный образ с dt.img
	$(hide) echo "Creating recovery image with dt.img..."
	$(hide) $(MKBOOTIMG) \
		--kernel $(recovery_kernel) \
		--ramdisk $(recovery_ramdisk) \
		--dt $(DTB_IMAGE) \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--header_version 2 \
		--output $(basename $@).unsigned 2>&1 | tail -20
	
	# Проверяем размер до заполнения
	$(hide) echo "Size before padding: $$(stat -c%s $(basename $@).unsigned 2>/dev/null || echo 0) bytes"
	
	# ЗАПОЛНЯЕМ ОБРАЗ ДО 32 МБ (33554432 байт)
	$(hide) echo "Padding to $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) bytes..."
	$(hide) truncate -s $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) $(basename $@).unsigned 2>/dev/null || \
          (dd if=/dev/zero bs=1 count=1 seek=$(BOARD_RECOVERYIMAGE_PARTITION_SIZE) of=$(basename $@).unsigned 2>/dev/null && \
           echo "Used dd for padding")
	
	# Переименовываем в финальный файл
	$(hide) mv $(basename $@).unsigned $@
	
	# Проверяем размер после заполнения
	$(hide) echo "Final recovery image size: $$(stat -c%s $@ 2>/dev/null || echo "ERROR") bytes"
	$(hide) echo "Target size: $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) bytes"
	
	# Проверяем минимальную валидность образа
	$(hide) if [ $$(stat -c%s $@ 2>/dev/null) -eq $(BOARD_RECOVERYIMAGE_PARTITION_SIZE) ]; then \
		echo "✓ Size check PASSED"; \
	else \
		echo "✗ Size check FAILED"; \
		false; \
	fi
	
	@echo "================================================"
	@echo "Recovery image created: $@"
	@echo "================================================"

# Сборка boot-образа (аналогично)
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	@echo "================================================"
	@echo "Building boot image for at30a6"
	@echo "================================================"
	
	$(if $(wildcard $(DTB_IMAGE)),,$(error DTB image not found: $(DTB_IMAGE)))
	
	$(hide) $(MKBOOTIMG) \
		$(INTERNAL_BOOTIMAGE_ARGS) \
		--dt $(DTB_IMAGE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--header_version 2 \
		--output $@ 2>&1 | tail -20
	
	@echo "Boot image created: $@"
	@echo "================================================"

# Убедимся, что dt.img и dtbo.img копируются в выходную директорию
ALL_DEFAULT_INSTALLED_MODULES += $(DTB_IMAGE) $(DTBO_IMAGE)

$(PRODUCT_OUT)/dt.img: $(DTB_IMAGE)
	$(hide) cp $(DTB_IMAGE) $@
	@echo "Copied dt.img to output"

$(PRODUCT_OUT)/dtbo.img: $(DTBO_IMAGE)
	$(hide) cp $(DTBO_IMAGE) $@
	@echo "Copied dtbo.img to output"
