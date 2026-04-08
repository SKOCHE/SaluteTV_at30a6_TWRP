#!/sbin/sh
echo "Fixing MR config paths..."

mkdir -p /odm_ext/etc/mr 2>/dev/null
mkdir -p /vendor/etc/mr 2>/dev/null

if [ -d /sbin/mr ]; then
    echo "  Copying remote configs..."
    cp -r /sbin/mr/* /odm_ext/etc/mr/ 2>/dev/null
    cp -r /sbin/mr/* /vendor/etc/mr/ 2>/dev/null
    echo "  Remote configs copied"
fi

echo "MR paths fixed!"