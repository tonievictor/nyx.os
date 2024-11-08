print_string:
	pusha
	mov si, bx

  loop:
	lodsb
	cmp al, 0
	je done
	int 0x10
	jmp loop

	done:
	popa
	ret
