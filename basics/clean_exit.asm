global _start; export the entrypoint

section .text; loaded in the executable section of ELF

_start: ; main execution starts here

	;   exit(0)
	mov rax, 0x3c; sys_exit
	mov rdi, 0; exit_code = 0 = EXIT_SUCCESS
	syscall
