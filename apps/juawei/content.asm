section .data
        info db "Welcome to Juawei! A totally not ripped off name from Huawei, enjoy the default apps or create your own!", 10
        len equ $-info
section .text
        global _start
_start:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, info
        mov     rdx, len
        syscall
        mov     rax, 60
        xor     rdi, rdi
        syscall
