section .data
        link db "discord.gg/claneu", 10

section .text
        global _start
_start:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, link
        mov     rdx, 18
        syscall
        mov     rax, 60
        xor     rdi, rdi
        syscall
