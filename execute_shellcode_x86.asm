section .text
global _start

_start:
    ; Place shellcode here
    jmp shellcode

shellcode:
    ; Insert shellcode here
    db 0x90 ; NOP instruction
    db 0x90 ; NOP instruction
    db 0x90 ; NOP instruction

    ; Call the shellcode
    call shellcode

    ; Return to the operating system
    xor eax, eax
    mov al, 1
    xor ebx, ebx
    int 0x80
