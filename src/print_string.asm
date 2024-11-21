print_string:
	pusha
	mov si, bx

	mov ah, 0x0e

loop:
	lodsb
	cmp al, 0
	je  done
	int 0x10
	jmp loop

done:
	popa
	ret

;[bits 32]

	; VIDEO_MEMORY equ 0xb8000
	; WHITE_ON_BLACK equ 0x0f

;print_string_pm:
	; pusha
	; mov edx, [VIDEO_MEMORY]

;print_string_loop:
	; mov al, [ebx]
	; mov ah, WHITE_ON_BLACK

	; cmp al, 0
	; je done

	; mov [edx], ax
	; add edx, 2

	; jmp print_string_loop
