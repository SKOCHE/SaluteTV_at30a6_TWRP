# SaluteTV (at30a6) TWRP Device Tree

## Device Information
- **Model**: SaluteTV
- **Codename**: at30a6
- **Platform**: Amlogic
- **Android Version**: 13 (SDK 33)
- **Architecture**: ARM 32-bit (armeabi-v7a)
- **Kernel**: Linux 4.x
- **Stock Firmware**: v1.100.61-b23081

## Partition Sizes
- Boot: 64 MB (67,108,864 bytes)
- Recovery: 32 MB (33,554,432 bytes)
- DTBO: 2 MB (2,097,152 bytes)

## Building Instructions
1. Clone TWRP source:
   ```bash
   repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-13
   repo sync

