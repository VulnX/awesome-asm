global chad_strcmp

extern chad_strlen

section .text

chad_strcmp:
	call chad_strlen
	mov  rcx, rax
	push rdi
	mov  rdi, rsi
	call chad_strlen
	pop  rdi
	cmp  rax, rcx
	jne  chad_strcmp_ret_ne

chad_strcmp_loop:
	mov  al, byte [rsi]
	cmp  byte [rdi], al
	jne  chad_strcmp_ret_ne
	inc  rsi
	inc  rdi
	loop chad_strcmp_loop
	mov  rax, 1
	jmp  chad_strcmp_ret

chad_strcmp_ret_ne:
	mov rax, 0

chad_strcmp_ret:
	ret
