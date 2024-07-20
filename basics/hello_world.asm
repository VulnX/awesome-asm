global _start; export the entrypoint

section .text; loaded in the executable section of ELF

_start: ; main execution starts here

	;   write(1, "Hello, World!\n", strlen("Hello, World!"))
	mov rax, 1; sys_write
	mov rdi, 1; fd = 1 ( stdout )
	lea rsi, [rel message]
	mov rdx, [length]
	syscall

	;   exit(0)
	mov rax, 0x3c; sys_exit
	mov rdi, 0; exit_code = 0 = EXIT_SUCCESS
	syscall

	section .data

message:
	db "Hello, World!", 0xa

length:
	db $-$message
