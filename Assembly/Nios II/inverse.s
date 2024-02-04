# Author: Ryan Silverberg
# Purpose: To find the inverse of a gcd(a,b)

.text
.global _start
.org 0x0000

_start:
    movia sp, 0x7FFFFC
    call Inverse


_end:
    break

Inverse:
    subi sp,sp,32       # Allocate Stack Memory
    stw r2, 0(sp)       # Dividend
    stw r3, 4(sp)       # Divisor
    stw r4, 8(sp)       # Quotient
    stw r5, 12(sp)      # Remainder
    stw r6, 16(sp)      # GCD Holder
    stw r7, 20(sp)      # X1
    stw r8, 24(sp)      # Y1
    stw r9, 28(sp)      # Arithmetic Holder

    movia r2, NUM    	# mov address of N1
    movia r3, MOD     	# mov address of N2
    movi r7, 0          # Store Init Value of X1
    movi r8, 1          # Store Init Value of Y1
    ldw r2, 0(r2)       # load immediate
    ldw r3, 0(r3)       # load immediate

Loop:

    beq r3,r0, EndLoop  # If Divisor 0

CalcRemainder:
    div r4, r2,r3       # Divide Dividend/Divisor
    mul r9, r4,r7       # Multiply first half of Extended Euclidean
    mov r8, r7          # Move X into Y
    sub r7, r8,r9       # Complete Euclidean Calculation
    mul r5, r4,r3       # Multiply Quotient*Divisor
    sub r5, r2,r5       # Subtract Dividend-(Quotient*Divisor)

ContinueEuclidean:
    mov r2, r3          # Move Divisor --> Dividend
    mov r6, r3          # Store current GCD <-- Divisor
    mov r3, r5          # Move Remainder --> Divisor
    
    bge r5,r0, Loop     # If remainder > 0

EndLoop:

    stw r6, GCD(r0)     # Store GCD in memory
    stw r7, X(r0)		# Store X in memory
    stw r8, Y(r0)    	# Store Y in memory

    ldw r2, 0(sp)       # Dividend
    ldw r3, 4(sp)       # Divisor
    ldw r4, 8(sp)       # Quotient
    ldw r5, 12(sp)      # Remainder
    ldw r6, 16(sp)      # GCD Holder
    ldw r7, 20(sp)      # X1
    ldw r8, 24(sp)      # Y1
    ldw r9, 28(sp)      # Arithmetic Holder
    addi sp,sp,32       # Deallocate Stack Memory

    ret

.org 0x1000
NUM: .word 123
MOD: .word 4567

X: .skip 4
Y: .skip 4

GCD: .skip 4


.end