ASM=nasm

SRC_DIR=src

build: main.bin main_floppy.img

main_floppy.img: main.bin
	cp main.bin main_floppy.img
	truncate -s 1440k main_floppy.img
main.bin: $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/main.asm -f bin -o main.bin

run:
	qemu-system-i386 -fda main_floppy.img
