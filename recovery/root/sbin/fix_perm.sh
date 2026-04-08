#!/sbin/sh
echo "Fixing permissions..."

# Main binaries
chmod 755 /sbin/adbd
chmod 755 /sbin/adbd_binary
chmod 755 /sbin/busybox
chmod 755 /sbin/sh 2>/dev/null
chmod 755 /sbin/simple_sh 2>/dev/null

# Scripts
chmod 755 /sbin/fix_perm.sh
chmod 755 /sbin/create_links.sh 2>/dev/null
chmod 755 /sbin/fix_mr_paths.sh 2>/dev/null

# ADB libraries
if [ -d /sbin/lib ]; then
    chmod 644 /sbin/lib/*.so 2>/dev/null
    echo "  ADB libraries permissions fixed"
fi

# Remote control configs
if [ -d /sbin/mr ]; then
    chmod 644 /sbin/mr/* 2>/dev/null
    echo "  Remote configs permissions fixed"
fi

# Create necessary directories
mkdir -p /tmp
mkdir -p /dev
mkdir -p /sys
mkdir -p /proc
mkdir -p /system
mkdir -p /vendor

echo "Permissions fixed successfully!"