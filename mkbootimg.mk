# mkbootimg.mk для принудительной сборки recovery.img 32MB

# Переопределение сборки recovery-образа
$(INSTALLED_RECOVERYIMAGE_TARGET):
	@echo "=== Building recovery.img with padding to 32MB ==="
	
	# Создаем образ с помощью mkbootimg
	$(hide) mkdir -p $(dir $@)
	$(hide) out/host/linux-x86/bin/mkbootimg \
		--kernel $(TARGET_PREBUILT_KERNEL) \
		--ramdisk $(call intermediates-dir-for,PACKAGING,recovery_ramdisk)/recovery_ramdisk.cpio.gz \
		--dt device/salute/at30a6/prebuilt/dt.img \
		--cmdline "$(BOARD_KERNEL_CMDLINE)" \
		--base $(BOARD_KERNEL_BASE) \
		--pagesize $(BOARD_KERNEL_PAGESIZE) \
		--kernel_offset $(BOARD_KERNEL_OFFSET) \
		--ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
		--tags_offset $(BOARD_TAGS_OFFSET) \
		--header_version 2 \
		--output $@.tmp
	
	# Заполняем до 32MB
	$(hide) truncate -s 33554432 $@.tmp 2>/dev/null || \
		dd if=/dev/zero of=$@.tmp bs=1 count=0 seek=33554432 2>/dev/null
	
	$(hide) mv $@.tmp $@
	
	@echo "Recovery image created: $@"
	@echo "Size: $$(stat -c%s $@) bytes"
