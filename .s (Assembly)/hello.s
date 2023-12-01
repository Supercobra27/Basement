.global _start
.intel_syntax noprefix
//Intel  Implementation which hopefully works on my AMD

_start:

    //sys_write
    mov rax, 1 //sys_write
    mov rdi, 1 //error code
    lea rsi, [hello_world] //string buffer
    mov rdx, 14 //string size
    syscall


    //sys_exit
    mov rax, 60 //sys_exit
    move rdi, 2 //error code
    syscall //sys_exit

hello_world:
    .asciz "Hello World!\n"