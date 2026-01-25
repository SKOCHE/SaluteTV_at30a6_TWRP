# SaluteTV (at30a6) TWRP Device Tree

## Device Information
- **Device**: SaluteTV (кодовое имя: at30a6)
- **Platform**: Amlogic
- **Android**: 13 (SDK 33)
- **Architecture**: ARM 32-bit (armeabi-v7a)
- **Kernel**: Linux 4.x (zImage)
- **Partitions**: boot=64MB, recovery=32MB, dtbo=2MB

## Features
- TWRP 3.7.x recovery
- Support for Android 13
- FBE/FDE encryption support
- MTP and ADB support
- Brightness control
- Backup/Restore functionality

## Building
1. Clone this repo to TWRP source:
   ```bash
   git clone https://github.com/your-username/SaluteTV_at30a6_TWRP.git
   cp -r SaluteTV_at30a6_TWRP/device/salute/ /path/to/twrp-source/device/
