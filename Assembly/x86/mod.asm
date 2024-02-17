; Author: Ryan Silverberg
; Purpose: To compute modular arithmetic on two numbers

.text

main:
    push rbp                ; Push onto the stack
    mov rbp, rsp            ; Move the stack pointer onto the base pointer
    mov DW PTR [rbp-4], 4567
    mov DW PTR [rbp-8], 123
    mov rax, DW PTR [rbp-4]
    cdq
    idiv DW PTR [rbp-12]
    mov DW PTR [rbp-12], rdx
    mov rax, 0
    pop rbp
    ret
