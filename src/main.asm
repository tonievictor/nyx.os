[org 0x7c00]

mov bp, 0x9000; setup stack
mov sp, bp

mov  bx, MSG_REAL_MODE
call print_string

	call switch_to_pm
	jmp  $

%include "src/print_string.asm"
%include "src/print_hex.asm"
%include "src/disk.asm"
%include "src/switch_pm.asm"
%include "src/gdt.asm"

[bits 32]

BEGIN_PM:
	mov  ebx, MSG_PROCTECTED_MODE
	call print_string_pm

	jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROCTECTED_MODE db "Successfully switched to protected mode", 0

times 510-($-$$) db 0
dw    0xaa55
