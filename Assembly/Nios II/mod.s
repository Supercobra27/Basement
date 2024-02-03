.text
.global _start
.org 0x0000

_start:
    movia sp, 0x7FFFFC
    call ModArith
_end:
    break


ModArith:

    subi sp,sp,16
    stw r2, 0(sp)
    stw r3, 4(sp)
    stw r4, 8(sp)
    stw r5, 12(sp)

    movia r2, num
    movia r3, mod
    ldw r2, 0(r2)
    ldw r3, 0(r3)

    div r4, r2,r3
    mul r5, r4,r3
    sub r5, r2,r5

    stw r5, rma(r0)

    ldw r2, 0(sp)
    ldw r3, 4(sp)
    ldw r4, 8(sp)
    ldw r5, 12(sp)
    addi sp,sp,16
    ret

.org 0x1000

mod:   .word 4
num:   .word 7
rma:   .skip 4