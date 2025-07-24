section .data
        gre db "1: Add 2: Subtract", 10
        len equ $-gre
        e db "=",0
        p db "+",0
section .bss
        buf resb 1
        jfkaws resb 1
        p1 resq 1
        p2 resq 1
section .text
        global _start

_start:
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, gre
        mov     rdx, len
        syscall
        mov     rax, 0
        mov     rdi, 0
        mov     rsi, buf
        mov     rdx, 2
        syscall
        push rsi
        mov     rax, 0
        mov     rax, 0
        mov     rdi, 0
        mov     rsi, p1
        mov     rdx, 2
        syscall
        mov     r8, p1
        mov     rax, 0
        mov     rdi, 0
        mov     rsi, p2
        mov     rdx, 2
        syscall
        mov     r9, p2
        pop     rsi
        push    r8
        push    r9
        push    rsi
        mov     r8, [p1]
        mov     r9, [p2]
        sub     r8, 48
        sub     r9, 48
        cmp     byte[rsi], '1'
        je      add
        cmp     byte[rsi], '2'
        je      subtract
exit:
        mov     rax, 60
        xor     rdi, rdi
        syscall
print:
        mov     rax, 1
        mov     rdi, 1
        syscall
        ret
add:
        mov     r10, r8
        add     r10, r9
        pop     r8
        pop     r9
        add     r10, 48
        mov     byte [jfkaws], r10b
        mov     rsi, r8
        mov     rdx, 2
        call    print
        mov     rsi, p
        mov     rdx, 1
        call    print
        mov     rsi, r9
        mov     rdx, 1
        call    print
        mov     rsi, e
        mov     rdx, 2
        call    print
        mov     rsi, jfkaws
        mov     rdx, 1
        call    print
        jmp exit
subtract:
        mov     r10, r8
        sub     r10, r9
        add     r10, 48
        mov     byte [jfkaws], r10b
        mov     rax, 1
        mov     rdi, 1
        mov     rsi, jfkaws
        mov     rdx, 1
        syscall
        jmp exit
