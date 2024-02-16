.text
.global _start
.org 0x0000

# Source: https://cp-algorithms.com/algebra/binary-exp.html

_start:
    movia sp, 0x7FFFFC
    call primeExp



_end:

primeExp:
    subi sp,sp, 24
    stw r2, 0(sp)
    stw r3, 4(sp)
    stw r4, 8(sp)
    stw r5, 12(sp)
    stw r6, 16(sp)
    stw r7, 20(sp)

    movia r2, B
    movia r3, N
    movia r4, M
    movi r5, 1

    ldw r2, 0(r2)
    ldw r3, 0(r3)
    ldw r4, 0(r4)
    
ModBM:
    div r6, r2, r4
    mul r6, r4, r6
    sub r6, r2, r6

    stw r6, Power(r0)

Loop:

if1:
    movi r6, 2

    div r7, r3, r6
    mul r7, r6, r7
    sub r7, r3, r7
    
    movi r6, 1

    bne r7, r6, end1

then1:

    mov r7, r0

    movia r6, Power
    ldw r6, 0(r6)

    ldw r5, Ans(r0)

    mul r5, r5, r6

    div r7, r5, r4
    mul r7, r4, r7
    sub r7, r5, r7
    mov r5, r7

    stw r5, Ans(r0)

    srli r3, r3, 1

end1:

    mov r7, r0

if2:

    bge r3, r0, end2

then2:

    mov r7, r0

    movia r6, Power
    ldw r6, 0(r6)

    mul r5, r6, r6

    div r7, r5, r4
    mul r7, r4, r7
    sub r7, r5, r7
    mov r6, r7

    stw r6, Power(r0)

end2:

    mov r7, r0

    bge r3, r0, Loop

    stw r5, Ans(r0)

    ldw r2, 0(sp)
    ldw r3, 4(sp)
    ldw r4, 8(sp)
    ldw r5, 12(sp)
    ldw r6, 16(sp)
    ldw r7, 20(sp)
    addi sp,sp, 24
    ret





.org 0x1000
B:  .word
N:  .word
M:  .word 
Power: .skip 4
Ans:    .skip 8