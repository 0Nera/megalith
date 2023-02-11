.PHONY: all


all: bin GeorgyOS.iso
	make -C src
	xorriso -as mkisofs -b limine-cd.bin \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		--efi-boot limine-cd-efi.bin \
		-efi-boot-part --efi-boot-image --protective-msdos-label \
		isodir -o GeorgyOS.iso


#limine:
#	git clone https://github.com/limine-bootloader/limine.git --branch=v4.x-branch-binary --depth=1
#	make -C limine
#	make -C limine install


GeorgyOS.iso:  src
	xorriso -as mkisofs -b limine-cd.bin \
		-no-emul-boot -boot-load-size 4 -boot-info-table \
		--efi-boot limine-cd-efi.bin \
		-efi-boot-part --efi-boot-image --protective-msdos-label \
		isodir -o GeorgyOS.iso


bin:
	mkdir -p bin


deploy:
	limine-deploy GeorgyOS.iso


run: bin isodir
	qemu-system-i386 -m 64 -serial file:serial.log -rtc base=localtime -cdrom GeorgyOS.iso