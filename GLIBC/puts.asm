global chad_puts

extern chad_print

section .text

chad_puts:
	call chad_print
	mov  rax, 1
	mov  rdi, 1
	mov  rsi, 0x0a
	push rsi
	mov  rsi, rsp
	mov  rdx, 1
	syscall
	pop  rsi
	ret
