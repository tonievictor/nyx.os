disk_load:
	push dx

	mov ah, 0x02 ; BIOS routine to read sector

	; setup
	mov al, dh ; set the amound of sectors to read
	mov ch, 0x00 ; select the 0th cylinder
	mov dh, 0x00 ; select the 0th head
	mov cl, 0x02 ; start reading from the secong sector (the boot sector is
							 ; technically in the first)

	int 0x13		 ; call the BIOS interrupt
	jc disk_error; jump if an error occured

	pop dx ; restore the dx register
	cmp dh, al ; check if we're at the end (ie loop condition)
	jne disk_error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $

;Variables
DISK_ERROR_MSG: db "An error occured while reading from disk!", 0
