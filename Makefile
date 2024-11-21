ASM=nasm
CC=gcc
KERNEL.C=kernel/kernel.c
KERNEL.ASM=kernel/kernel_entry.asm
BOOT_SECT.ASM=boot/boot_sector.asm

os.image: boot_sect.bin kernel.bin
	cat $^ > os.img

kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

kernel.o: $(KERNEL.C)
	$(CC) -ffreestanding -c $< -o $@

kernel_entry.o: $(KERNEL.ASM)
	$(ASM) $(KERNEL.ASM) -f elf64 -o $@

clean:
	rm *.bin *.o *.dis

boot_sect.bin: $(BOOT_SECT.ASM)
	$(ASM) $< -f bin -o $@

run: os.image
	@qemu-system-x86_64 -drive format=raw,index=0,media=disk,file=os.img

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
