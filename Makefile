ASM=nasm
CC=gcc
C_SOURCES=$(wildcard kernel/*.c drivers/*.c)
HEADERS=$(wildcard kernel/*.h drivers/*.h)
OBJ=${C_SOURCES:.c=.o}

os.image: boot/boot_sector.bin kernel.bin
	cat $^ > os.img

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	$(CC) -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf64 -o $@

clean:
	@find . -type f \( -name "*.bin" -o -name "*.o" -o -name "*.dis" \) -exec rm {} \;

%.bin: %.asm
	$(ASM) $< -f bin -o $@

run: os.image
	@qemu-system-x86_64 -drive format=raw,index=0,media=disk,file=os.img

%.dis: %.bin
	ndisasm -b 32 $< > $@
