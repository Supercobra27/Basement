.text
.global _start
.org 0x0000


_start:
    movia sp, 0x7FFFFC  # Initialize Stack Pointer
    call CalculateGCD

_end:
    break

CalculateGCD:
    subi sp,sp,20       # Allocate Stack Memory
    stw r2, 0(sp)       # Dividend
    stw r3, 4(sp)       # Divisor
    stw r4, 8(sp)       # Quotient
    stw r5, 12(sp)      # Remainder
    stw r6, 16(sp)      # GCD Holder

    movia r2, N1        # mov address of N1
    movia r3, N2        # mov address of N2
    ldw r2, 0(r2)       # load immediate
    ldw r3, 0(r3)       # load immediate

Loop:

CalcRemainder:
    div r4, r2,r3       # Divide Dividend/Divisor
    mul r5, r4,r3       # Multiply Quotient*Divisor
    sub r5, r2,r5       # Subtract Dividend-(Quotient*Divisor)

ContinueEuclidean:
    mov r2, r3          # Move Divisor --> Dividend
    mov r3, r5          # Move Remainder --> Divisor

    beq r5, r0, SkipIf   # Skip if equals 0

    mov r6, r5          # Store current GCD
    
    bgt r5,r0, Loop     # If remainder > 0

SkipIf:

    stw r6, GCD(r0)

    ldw r2, 0(sp)       # Dividend
    ldw r3, 4(sp)       # Divisor
    ldw r4, 8(sp)       # Quotient
    ldw r5, 12(sp)      # Remainder
    ldw r6, 16(sp)      # GCD Holder
    addi sp,sp,20       # Deallocate Stack Memory

    ret


.org 0x1000

N1:     .word 4
N2:     .word 2
GCD:    .skip 4


.end