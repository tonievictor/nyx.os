org 0x7c00 ;specify the origin address where the code will be loaded
bits 16 ; set the assembly code to generate 16bit instructions

; defines a macro ENDL as a sequence of 2 bytes
; each representing the carriage return character '\r' and
; the line feed character '\n'
%define ENDL 0x0D, 0x0A

; Entry point of the program
start:
	jmp main ; jmps to the main label (function?)

;Puts a string to the output medium
; Parameter:
;	- ds si: points to the string
puts:
	push si ; saves the si register
	push ax ; saves the ax register

.loop:
	lodsb ; loads next byte (character?) from the string into AL
	or al, al ; verifies if the byte is null (end of the string)
	jz .done ; if null, exit the loop

	mov ah, 0x0e ; set ah to point to 0x0e, this specifies the teletype output function
	mov bh, 0 ; set bh to point to 0 which is the current page
	int 0x10 ; call the bios interrupt to execute the function specified in ah

	jmp .loop ; continue looping

.done:
	pop ax ; restore the ax register
	pop si ; restore the si register
	ret ; return from the function

main:
	mov ax, 0 ; initialize data segment to zero
	mov ds, ax ; set ds to point to the data segment
	mov es, ax ; set es to point to the data segement

	; setup the stack segmebt
	mov ss, ax ; set the stack segment to the data segment
	mov sp, 0x7c00 ; set the stack pointer to the origin address
	; since the stack grows downwards, we set the stack pointer 
	; to the origin of our os so as o avoid overriding data

	mov si, msg_hello
	call  puts

	hlt ; halt the cpu

.halt: ; indefinte loop for halting
	jmp .halt

msg_hello: db 'Hello World!', ENDL, 0 ; save the string Hello World and a new line

; 510-($-$$) calculates number of bytes left to fill the
; 510 byte in the boot sector
; db 0 instruction fills the rest of the boot sector with zeros
times 510-($-$$) db 0
dw  0AA55h ; boot sector signature
