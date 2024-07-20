global chad_strlen

section .text

chad_strlen:
	mov rax, 0

chad_strlen_loop:
	cmp byte [rdi], 0
	jz  chad_strlen_done
	inc rax
	inc rdi
	jmp chad_strlen_loop

chad_strlen_done:
	sub rdi, rax
	ret
