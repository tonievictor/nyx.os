gdt_start:
	; used to signify the start of the gdt table

gdt_null:
	;  mandatory null descriptor
	dd 0x0
	dd 0x0; 'dd' means define double word (4 bytes)

gdt_code:
	;  code segment descriptor
	;  base=0x0, limit=0xfffff
	;  1st flags : (present)1 (privilege)00 (descriptor type)1 -> 1001b
	;  type flags : (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
	;  2nd flags : (granularity)1 (32-bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
	dw 0xffff; limit (bits 0-15)
	dw 0x0; base (bits 16-23)
	db 0x0; base (bits 16 -23)
	db 10011010b; 1st flags, type flags
	db 11001111b; 2nd flags, Limit (bits 16 - 19)
	db 0x0; Base (bits 24 - 31)

gdt_data:
	;  data segment descriptor
	;  same as code segment save for the type flags
	;  type flags: (code)0 (expand down)0 (writable)1 (accessed)0 -> 0010b
	dw 0xffff
	dw 0x0
	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_end:
	; used to signify the end of the gdt table

gdt_descriptor:
	dw gdt_end - gdt_start - 1; calculate the gdt, always 1 less than the true
	;size
	dd gdt_start; start address of the gdt

	; GDT segment descriptor offsets
	; segment registers should ideally contain this when in protected mode
	; (0x0 -> NULLl; 0x08 -> CODE; 0x10 -> DATA)
	CODE_SEG equ gdt_code - gdt_start
	DATA_SEG equ gdt_data - gdt_start
