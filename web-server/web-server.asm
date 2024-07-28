global _start

section .text

strchr:
	;   ARG0 = RDI = string
	;   ARG1 = RSI = char
	;   implementation
	mov rax, rdi

strchr_check:
	cmp byte [rax], sil
	jne strchr_next
	ret

strchr_next:
	inc rax
	jmp strchr_check

strlen:
	;    ARG0 = RDI = string
	mov  rsi, 0
	call strchr
	sub  rax, rdi
	ret

get_pointer_to_data:
	lea rax, [rel request]

get_pointer_to_data_check:
	cmp dword [rax], 0x0a0d0a0d
	jne get_pointer_to_data_next
	add rax, 4
	ret

get_pointer_to_data_next:
	inc rax
	jmp get_pointer_to_data_check

_start:

	;   create socket
	mov rax, 41
	mov rdi, 2
	mov rsi, 1
	mov rdx, 0
	syscall
	mov r10, rax; save socket_fd to R10

	;    bind socket
	mov  rax, 49
	mov  rdi, r10
	mov  rsi, 0x50000002
	push rsi
	mov  rsi, rsp
	mov  rdx, 0x10
	syscall

	;   listen for connections
	mov rax, 50
	mov rdi, r10
	mov rsi, 0
	syscall

accept:
	;   accept connection
	mov rax, 43
	mov rdi, r10
	mov rsi, 0
	mov rdx, 0
	syscall
	mov r12, rax; save conection_fd to R12

	mov rax, 57
	syscall

	cmp rax, 0
	jne parent
	;   handle child here

	;   close socket
	mov rax, 3
	mov rdi, r10
	syscall

	;   read request
	mov rax, 0
	mov rdi, r12
	lea rsi, [rel request]
	mov rdx, 1000
	syscall

	lea  rdi, [rel request]
	mov  rsi, 0x20
	call strchr
	sub  rax, rdi
	;    lazy way to check if request type is GET or POST
	;    if RAX = 3 => its GET
	;    if RAX = 4 => its POST
	cmp  rax, 3
	jne  handle_post

handle_get:
	nop

	;   write response
	mov rax, 1
	mov rdi, r12
	lea rsi, [rel response]
	mov rdx, 19
	syscall

	lea  rdi, [rel request+4]
	mov  rsi, 0x20
	call strchr
	mov  byte [rax], 0x00
	sub  rax, rdi
	mov  rax, 2
	mov  rsi, 0
	mov  rdx, 0
	syscall
	push rax

	mov rax, 0
	mov rdi, qword [rsp]
	lea rsi, [rel file_content]
	mov rdx, 1000
	syscall

	mov rdx, rax
	mov rax, 1
	mov rdi, r12
	lea rsi, [rel file_content]
	syscall

	pop rdi
	mov rax, 3
	syscall

	jmp handle_complete

handle_post:
	;    get filename
	lea  rdi, [request+5]
	mov  rsi, 0x20
	call strchr
	mov  byte [rax], 0x00

	;    open file in O_WRONLY | O_CREAT, 0777
	mov  rax, 2
	mov  rsi, 0x41
	mov  rdx, 0x1ff
	syscall
	push rax

	call get_pointer_to_data
	mov  rbx, rax
	mov  rdi, rax
	mov  rsi, 0x00
	call strchr
	sub  rax, rbx
	;    At this point, RBX => pointer to request data
	;    And RAX => length of request data

	;   write request data to file
	mov rdx, rax
	mov rax, 1
	mov rdi, qword [rsp]
	mov rsi, rbx
	syscall

	;   close file
	pop rdi
	mov rax, 3
	syscall

	;   write response
	mov rax, 1
	mov rdi, r12
	lea rsi, [rel response]
	mov rdx, 19
	syscall

handle_complete:
	jmp exit

parent:
	;   close connection
	mov rax, 3
	mov rdi, r12
	syscall
	jmp accept

exit:
	mov rax, 60
	mov rdi, 0
	syscall

response:
	db "HTTP/1.0 200 OK", 13, 10, 13, 10

	section .bss

	request resb 1000

	file_content resb 1000
