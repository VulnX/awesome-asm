global chad_print

extern chad_strlen

section .text

chad_print:
	call chad_strlen
	mov  rdx, rax
	mov  rsi, rdi
	mov  rax, 1
	mov  rdi, 1
	syscall
	ret
