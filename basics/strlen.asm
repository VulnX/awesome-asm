global _start; export the entrypoint

section .text; loaded in the executable section of ELF

_start: ; main execution starts here

	;    strlen(message)
	lea  rdi, [rel message]
	call strlen
	mov  rdx, rax
	;    write(1, message, strlen(message))
	mov  rax, 1; sys_write
	mov  rdi, 1; fd = 1 ( stdout )
	lea  rsi, [rel message]
	syscall

	;   exit(0)
	mov rax, 0x3c; sys_exit
	mov rdi, 0; exit_code = 0 = EXIT_SUCCESS
	syscall

strlen:
	mov rax, 0; use as counter

strlen_loop:
	cmp byte [rdi], 0
	jz  strlen_done
	inc rax
	inc rdi
	jmp strlen_loop

strlen_done:
	ret

section .data

message:
	db "Hello, World!", 0xa, 0; always NULL terminate strings
