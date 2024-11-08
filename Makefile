ASM=nasm

SRC_DIR=src

build: main.bin main_floppy.img

main_floppy.img: loader.bin
	cp loader.bin loader.img
	truncate -s 1440k loader.img

main.bin:
	$(ASM) $(SRC_DIR)/main.asm -f bin -o loader.bin

run: build
	@qemu-system-x86_64 -drive format=raw,index=0,media=disk,file=loader.img

binary:
	od -t x1 -A n boot loader.bin
