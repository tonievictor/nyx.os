print_hex:
	pusha

	mov si, HEX_OUT
	mov cx, 12

	inc si
	inc si
hloop:
	mov bx, dx
	shr bx, cl
	and bx, 0x0f
	cmp bl, 9
	jle is_digit
	add bl, 0x37
	jmp store

is_digit:
	add bl, 0x30

store:
	cmp si, HEX_OUT + 6
	jge hprint
	mov [si], bl
	inc si
	sub cx, 4
	jmp hloop

hprint:
	mov bx, HEX_OUT 
	call print_string
	popa
	ret

HEX_OUT: db "0x0000!", 0
