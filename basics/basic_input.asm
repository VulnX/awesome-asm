global _start; export the entrypoint

section .text; loaded in the executable section of ELF

_start: ; main execution starts here

	;    write(1, prompt, strlen(prompt))
	lea  rdi, [rel prompt]
	call print

	;   read(0, data, 0x1000)
	mov rax, 0; sys_read
	mov rdi, 0; fd = 0 (stdin)
	lea rsi, [rel data]
	mov rdx, 0x1000
	syscall
	;   null terminate it
	dec rax
	add rsi, rax
	mov byte [rsi], 0

	;   exit(0)
	mov rax, 0x3c; sys_exit
	mov rdi, 0; exit_code = 0 = EXIT_SUCCESS
	syscall

print:
	call strlen
	mov  rdx, rax
	mov  rsi, rdi
	mov  rax, 1
	mov  rdi, 1
	syscall
	ret

strlen:
	mov rax, 0; use as counter

strlen_loop:
	cmp byte [rdi], 0
	jz  strlen_done
	inc rax
	inc rdi
	jmp strlen_loop

strlen_done:
	sub rdi, rax; restore rdi to original state
	ret

section .data

prompt:
	db "Enter your data : ", 0; always NULL terminate strings

	section .bss

data:
	resb 0x1000
