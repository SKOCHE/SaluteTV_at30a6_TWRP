# mkbootimg.mk для SaluteTV at30a6 - SIMPLE WORKING VERSION
# Без сложных проверок, работает с Ninja

# Add DTB to recovery image if it exists
ifneq ($(strip $(BOARD_PREBUILT_DTBIMAGE)),)
    ifeq ($(wildcard $(BOARD_PREBUILT_DTBIMAGE)),)
        $(warning DTB image not found: $(BOARD_PREBUILT_DTBIMAGE))
    else
        INTERNAL_RECOVERYIMAGE_ARGS += --dt $(BOARD_PREBUILT_DTBIMAGE)
    endif
endif

# Override recovery image build to add padding to 32MB
define build-recoveryimage-target
    @echo "================================================"
    @echo "Building recovery image for at30a6"
    @echo "Target size: 33554432 bytes (32 MB)"
    @echo "================================================"
    
    # Build temporary image
    $(hide) mkdir -p $(dir $(1))
    $(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $(1).tmp
    
    # Check size before padding
    $(hide) SIZE_BEFORE=$$(stat -c%s $(1).tmp 2>/dev/null || echo 0); \
            echo "Size before padding: $${SIZE_BEFORE} bytes"
    
    # Pad to 32MB (33554432 bytes)
    $(hide) if command -v truncate >/dev/null 2>&1; then \
                truncate -s 33554432 $(1).tmp; \
                echo "Used truncate for padding"; \
            else \
                dd if=/dev/zero of=$(1).tmp bs=1 count=0 seek=33554432 2>/dev/null; \
                echo "Used dd for padding"; \
            fi
    
    # Rename to final file
    $(hide) mv $(1).tmp $(1)
    
    # Verify final size
    $(hide) SIZE_AFTER=$$(stat -c%s $(1) 2>/dev/null || echo 0); \
            if [ $${SIZE_AFTER} -eq 33554432 ]; then \
                echo "✓ SUCCESS: Recovery image size: $${SIZE_AFTER} bytes"; \
            else \
                echo "✗ ERROR: Wrong size: $${SIZE_AFTER} bytes (expected: 33554432)"; \
                false; \
            fi
    
    @echo "Recovery image created: $(1)"
    @echo "================================================"
endef

# Apply the build function
$(INSTALLED_RECOVERYIMAGE_TARGET):
	$(call build-recoveryimage-target,$@)

# Also override boot image if needed
define build-bootimage-target
    @echo "Building boot image for at30a6"
    $(hide) mkdir -p $(dir $(1))
    $(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $(1)
    @echo "Boot image created: $(1)"
endef

$(INSTALLED_BOOTIMAGE_TARGET):
	$(call build-bootimage-target,$@)
