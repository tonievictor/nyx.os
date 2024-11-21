[bits 16]

switch_to_pm:
	cli ; switch off interrupts until we set-up the protected mode interrupt vector

	lgdt [gdt_descriptor]; load the GDT

	mov eax, cr0; make the switch to 32 bit mode by setting the first bit of
	or  eax, 0x1; control register (cr0)
	mov cr0, eax

	jmp CODE_SEG:init_pm; perform a far jump (ie to another segment)

[bits 32]

init_pm:
	;   Now in PM, we point our registers to the data segment defined in the gdt
	mov ax, DATA_SEG
	mov dx, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	;   update the stack positons so that it is at the top of our stack
	mov ebp, 0x9000
	mov esp, ebp

	call BEGIN_PM; let's go!!
