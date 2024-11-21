[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; memory offet into which the kernel is loaded

mov [BOOT_DRIVE], dl; bios stores the boot drive in dl so we store it in a memory location for later

mov bp, 0x9000; setup stack
mov sp, bp

mov  bx, MSG_REAL_MODE
call print_string

call load_kernel

call switch_to_pm

	jmp $

%include "boot/print_string.asm"
%include "boot/print_hex.asm"
%include "boot/disk.asm"
%include "boot/switch_pm.asm"
%include "boot/gdt.asm"

[bits 16]

load_kernel:
	mov  bx, MSG_LOAD_KERNEL
	call print_string

	mov  bx, KERNEL_OFFSET
	mov  dh, 15; load the first 15 sectors starting from from the boot disk (excluding the boot sector)
	mov  dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]

BEGIN_PM:
	mov  ebx, MSG_PROCTECTED_MODE
	call print_string_pm

	call KERNEL_OFFSET; ideally our kernel should be here init, so we just call the routine/function found here

	jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROCTECTED_MODE db "Successfully switched to protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

times 510-($-$$) db 0
dw    0xaa55
