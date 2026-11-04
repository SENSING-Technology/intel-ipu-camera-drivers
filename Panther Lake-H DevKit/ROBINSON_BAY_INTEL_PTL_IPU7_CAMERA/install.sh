#!/bin/bash
set -e
cd "$(dirname "$0")"

# CAMERA CONFIG：
# SHF3L:  8_shf3l_frame_sync
# M3A:  8_m3a_frame_sync
# SG3S_GMSL2F: 8_isx031f_frame_sync
# 
CAMERA=8_isx031f_frame_sync
KERNEL=6.18.23-lts-v6.18.23-deb-overlay-260427t075939z

# Install kernel and headers
dpkg -i kernel/linux-image-"$KERNEL"_*.deb kernel/linux-headers-"$KERNEL"_*.deb

# Install SSDT
sudo script/acpi/gen_ssdt.sh acpi/ipu7/robinson_bay/$CAMERA.asl

# Install pre-compiled drivers and firmware
mkdir -p "/lib/modules/$KERNEL/updates/dkms"
find . -type f -name '*.ko' -exec cp -t "/lib/modules/$KERNEL/updates/dkms" {} +
cp -r firmware/. /lib/firmware/

# Configure GRUB
mkdir -p /etc/default/grub.d
cat > /etc/default/grub.d/ssdt.cfg <<EOF
GRUB_EARLY_INITRD_LINUX_CUSTOM="img_ssdt.img"
GRUB_DEFAULT="Advanced options for Ubuntu>Ubuntu, with Linux $KERNEL"
EOF

# Update modules and initramfs
depmod -a "$KERNEL"
update-initramfs -u -k "$KERNEL"
update-grub
