# Author: Ryan Silverberg
# Purpose: Conduct Chinese Remainder Theorem on n=3 congruences

.text
.global _start
.org 0x0000

_start:
    movia sp, 0x7FFFFC
    call CRT

_end:
    break

CRT:
    subi sp, sp, 4
    stw ra, 0(sp)

BigM:
    movia r2, M
    movia r12, I

    ldw r3, 0(r2)
    ldw r4, 4(r2)
    ldw r5, 8(r2)

    mul r2, r3, r4
    mul r2, r2, r5

    mov r17, r2

    div r3, r17, r3  # M1
    addi r12, r12, 0
    movi r2, 4
    call Inverse

    div r4, r17, r4  # M2
    addi r12, r12, 4
    movi r2, 9
    mov r3, r4
    call Inverse

    div r5, r17, r5  # M3
    addi r12, r12, 4
    movi r2, 35
    mov r3, r5
    call Inverse


    ldw ra, 0(sp)
    addi sp, sp, 4
    ret

Inverse:
    subi sp,sp,36       # Allocate Stack Memory
    stw r2, 0(sp)       # Modulus (B1)
    stw r3, 4(sp)       # Number (A1)
    stw r4, 8(sp)       # Quotient
    stw r6, 12(sp)      # Store X1
    stw r7, 16(sp)      # Store Y1
    stw r8, 20(sp)      # Store X
    stw r9, 24(sp)      # Store Y
    stw r10, 28(sp)     # Arith Holder
    stw r11, 32(sp)     # Temp Value

    movi r6, 0          # Move 0 into X1
    movi r7, 1          # Move 1 into Y1
    movi r8, 1          # Move 1 into X
    movi r9, 0          # Move 0 into Y

Loop:

CalcInverse:
    div r4, r3, r2      # Q = A1/B1

CalcX:
    mov r11, r8         # Store init X
    mov r8, r6          # Move X <-- X1
    mul r10, r4, r6     # Q*X1
    sub r6, r11, r10    # X-Q*X1

CalcY:
    mov r11, r9        # Store init Y
    mov r9, r7         # Move Y <-- Y1
    mul r10, r4, r7    # Q*Y1
    sub r7, r11, r10   # Y-Q*Y1

CalcGCD:
    mov r11, r3         # Store init A1
    mov r3, r2          # Move A1 <-- B1
    mul r10, r2, r4     # Q*B1
    sub r2, r11, r10    # A1-Q*B1

StoreInverse:
    stw r8, 0(r12)      # Store X in memory
    # stw r9, 0(r12)     # Store Y in memory
    beq r2, r0, EndLoop # If GCD = 0, break before it stores
    stw r2, GCD(r0)     # Store GCD in memory
    
    bgt r2,r0, Loop     # If B1 > 0

EndLoop:

    ldw r2, 0(sp)       # Dividend
    ldw r3, 4(sp)       # Divisor
    ldw r4, 8(sp)       # Quotient
    ldw r6, 12(sp)      # Load X1
    ldw r7, 16(sp)      # Load Y1
    ldw r8, 20(sp)      # Load X
    ldw r9, 24(sp)      # Load Y
    ldw r10, 28(sp)     # Arith Holder
    ldw r11, 32(sp)     # Temp Value
    addi sp,sp,36       # Deallocate Stack Memory

    ret


.org 0x1000 # x cong n (mod m)
C1: .word 0,4       # n, m
C2: .word 6,9       # n, m
C3: .word 28,35     # n, m
A:  .word 3         # Amount of Congruences
M:  .skip 12        # Store M1, M2, M3
I:  .skip 12        # Store y1, y2, y3
GCD:.skip 4         # Store GCD
.end