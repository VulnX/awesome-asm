global chad_exit

section .text

chad_exit:
	mov rax, 0x3c
	syscall
