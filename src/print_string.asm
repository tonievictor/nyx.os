print_string:
	pusha
	mov si, bx

	mov ah, 0x0e 

  loop:
	lodsb
	cmp al, 0
	je done
	int 0x10
	jmp loop

	done:
	popa
	ret
