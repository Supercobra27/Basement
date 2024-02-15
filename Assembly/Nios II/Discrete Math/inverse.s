# Author: Ryan Silverberg
# Purpose: Calculate the Extended Euclidean Algorithm

.text
.global _start
.org 0x0000


_start:
    movia sp, 0x7FFFFC  # Initialize Stack Pointer
    call InverseIterative

_end:
    break

InverseRecursive:
    movi r2, 123
    movi r3, 4567
    movi r6, 0
    movi r7, 1
    movi r8, 1
    movi r9, 0

BaseCase:
    bne r2, r0, Recursion
    movi r8, 1
    movi r9, 0
    ret
Recursion:



    
# Iterative Attempt
InverseIterative:
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

    movi r2, 123        # Get Modulus
    movi r3, 4567       # Get Number

Loop:

CalcInverse:
    div r4, r3, r2      # Divide Dividend/Divisor (Q)

CalcX:
    mov r11, r8         # Store init X
    mov r8, r6          # Move X <-- X1
    mul r10, r4, r6     # Q*X1
    sub r8, r11, r10    # X-Q*X1

CalcY:
    mov r11, r9        # Store init Y
    mov r9, r7         # Move Y <-- Y1
    mul r10, r4, r7    # Q*Y1
    sub r9, r11, r10   # Y-Q*Y1

CalcGCD:
    mov r11, r3         # Store init A1
    mov r3, r2          # Move A1 <-- B1
    mul r10, r2, r4     # Q*B1
    sub r2, r11, r10    # A1-Q*B1

StoreInverse:
    stw r2, GCD(r0)     # Store GCD in memory
    stw r8, X(r0)       # Store X in memory
    stw r9, Y(r0)       # Store Y in memory
    
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


.org 0x1000

Number: .word 4567
Modulus:.word 123
X:      .skip 4
Y:      .skip 4
GCD:    .skip 4

.end
