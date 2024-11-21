disk_load:
	push dx

	mov ah, 0x02; BIOS routine to read sector

	;setup
	mov al, dh; set the amound of sectors to read
	mov ch, 0x00; select the 0th cylinder
	mov dh, 0x00; select the 0th head

	mov cl, 0x02; start reading from the second sector (the boot sector is
	;   technically in the first)

	int 0x13; call the BIOS interrupt
	jc  disk_error; jump if an error occured

	pop dx; restore the dx register
	cmp dh, al; check if the sector read (al) is greater then the sectors to be
	jne disk_error; read.
	ret

disk_error:
	mov  bx, DISK_ERROR_MSG
	call print_string
	jmp  $

;Variables
DISK_ERROR_MSG: db "An error occured while reading from disk!", 0
