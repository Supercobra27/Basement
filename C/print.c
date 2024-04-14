// x86 Assembly
// Author: Ryan Silverberg

#include <stdio.h>

int getChar(){

    char ch = 'A';

    __asm__ (
        "movl $1, %%eax;"
        "movq $1, %%rdi;"
        "movq %0, %%rsi;"
        "movq $1, %%rdx;"
        "syscall;"
        : "r"(&ch)
        : "%rax", "%rdi", "%rsi", "%rdx"
    );

    return 1;
}

int main(){ 

    int hold = getChar();


    return 0;
}