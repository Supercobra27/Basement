.equ JTAG_ADD, 0x10001000   # Address of the JTAG UART register
.equ DATA, 0                # Data location for JTAG
.equ STATUS, 4              # Status offset for status location
.equ MASK, 0xFFFF           # Whitespace mask to isolate upper bits

.text
.global _start
.org 0x0000

_start:
    movia sp, 0x7FFFFC
    movia r5, Str
    call printString

_end:
    break

printChar:                  # Takes in r2 as character
    subi sp, sp, 8
    stw r3, 0(sp)
    stw r4, 4(sp)

    movia r3, JTAG_ADD      # r3 <--- [JTAG_ADD]
poll:
    ldwio r4, STATUS(r3)    # r4 <--- [STATUS]+[JTAG_ADD]
    andhi r4, r4, MASK      # r4 AND 0xFFFF
    beq r4, r0, poll        # If == 0, repeat loop

    stwio r2, DATA(r3)      # Store value from IO

    ldw r3, 0(sp)
    ldw r4, 4(sp)
    addi sp, sp, 8

    ret

printString:
    subi sp, sp, 8
    stw ra, 0(sp)
    stw r5, 4(sp)

Loop:
    ldb r2, 0(r5)
if:
    beq r5, r0, end
continue:
    call printChar
    addi r5, r5, 1
    br Loop
end:

    ldw r5, 4(sp)
    ldw ra, 0(sp)
    addi sp, sp, 8
    ret

.org 0x1000
Str: .asciz "This is a string!"