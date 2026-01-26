# mkbootimg.mk для SaluteTV at30a6 - УПРОЩЕННАЯ ВЕРСИЯ
# Убраны сложные проверки, которые могли вызывать lexing error

# Переопределение сборки recovery-образа
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(recovery_ramdisk) $(recovery_kernel)
	@echo "Building recovery image for at30a6"
	
	# Базовая команда mkbootimg с dt.img
	$(hide) $(MKBOOTIMG) \
		--kernel $(recovery_kernel) \
		--ramdisk $(recovery_ramdisk) \
		--dt device/salute/at30a6/prebuilt/dt.img \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--header_version 2 \
		--output $(basename $@).tmp
	
	# Заполнение до 32 МБ
	$(hide) truncate -s 33554432 $(basename $@).tmp
	$(hide) mv $(basename $@).tmp $@
	
	@echo "Recovery image created: $@"
