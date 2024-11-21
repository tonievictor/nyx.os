[org  0x7c00]
[bits 16]

mov [BOOT_DRIVE], dl; store the boot drive in BOOT_DRIVE

mov bp, 0x8000; setup stack far away at 0x8000th byte
mov sp, bp

mov  bx, 0x9000; load the 5 sectors to 0x0000(ES) : 0x9000(BX) from the boot
mov  dh, 5; disk
mov  dl, [BOOT_DRIVE]
call disk_load

mov  dx, [0x9000]; print out the first loaded wored in the first loaded sector
call print_hex

mov  dx, [0x9000 + 512]; print the word in the next sector
call print_hex

	jmp $

%include "src/print_string.asm"
%include "src/print_hex.asm"
%include "src/disk.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0

dw 0xaa55

times 256 dw 0xfade
times 256 dw 0xface
