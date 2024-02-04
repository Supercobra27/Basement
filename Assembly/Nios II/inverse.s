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


    ret

.org 0x1000


.end