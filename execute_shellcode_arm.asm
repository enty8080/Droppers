.arch armv7-a
.text
.align 2
.global _start

_start:
    // Allocate stack space
    sub sp, sp, #0x100

    // Copy shellcode to stack
    ldr r0, =shellcode
    ldr r1, =stack
    ldr r2, =shellcode_size
copy_loop:
    ldrb r3, [r0], #1
    strb r3, [r1], #1
    subs r2, r2, #1
    bne copy_loop

    // Change stack permissions to executable
    ldr r0, =stack
    ldr r1, =0x100
    mov r2, #0x7
    svc #0x0

    // Call shellcode
    blx stack

    // Exit
    mov r0, #0
    mov r7, #1
    svc #0x0

    .data
    .align 2
shellcode:
    // Insert shellcode here
stack:
    // Allocate stack space here
shellcode_size:
    .word shellcode_end - shellcode
shellcode_end:
