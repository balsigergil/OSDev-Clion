#!/usr/bin/env sh
mkdir -p isodir/boot/grub
cp cmake-build-debug/MyOS.bin isodir/boot/MyOS.bin
echo 'set timeout=0
set default=0
menuentry "MyOS" {
	multiboot /boot/MyOS.bin
}' > isodir/boot/grub/grub.cfg
grub-mkrescue -o MyOS.iso isodir
rm -rf isodir
