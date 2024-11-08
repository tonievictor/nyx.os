[org 0x7c00]
;BITS 16 

	mov [BOOT_DRIVE], dl

	mov bp, 0x8000
	mov sp, bp

	mov bx, 0x9000
	mov dh, 5
	mov dl, [BOOT_DRIVE]
	call disk_load 

	mov dx, [0x9000]
	call print_hex

	mov dx, [0x9000 + 512]
	call print_hex

	mov bx, HELLO_MSG
	call print_string

	mov bx, GOODBYE_MSG
	call print_string

	mov dx, 0x1fbf
	call print_hex

	jmp $

%include "src/print_string.asm"
%include "src/print_hex.asm"
%include "src/disk.asm"
HELLO_MSG: db "Hello, Tonie!", 0

GOODBYE_MSG: db "Goodbye!", 0

BOOT_DRIVE: db 0

times 510-($-$$) db 0

dw 0xaa55

times 256 dw 0xfade
times 256 dw 0xface
