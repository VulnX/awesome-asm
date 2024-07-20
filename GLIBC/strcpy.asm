global chad_strcpy

extern chad_strlen

section .text

chad_strcpy:
	push rdi
	mov  rdi, rsi
	call chad_strlen
	pop  rdi
	mov  rcx, rax

chad_strcpy_loop:
	mov  al, byte [rsi]
	mov  byte [rdi], al
	inc  rdi
	inc  rsi
	loop chad_strcpy_loop
	ret
