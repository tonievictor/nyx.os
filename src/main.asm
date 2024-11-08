[org 0x7c00]
;BITS 16 

main:
	mov bp, 0x8000
	mov sp, bp
	mov ah, 0x0e 

	mov bx, HELLO_MSG
	call print_string

	mov bx, GOODBYE_MSG
	call print_string

	mov dx, 0x1fbf
	call print_hex

	jmp $

%include "src/print_string.asm"
%include "src/print_hex.asm"

HELLO_MSG: db "Hello, Tonie!", 0

GOODBYE_MSG: db "Goodbye!", 0

times 510-($-$$) db 0

dw 0xaa55
