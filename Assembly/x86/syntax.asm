; Author: Ryan Silverberg
; Purpose: Basic Syntax Guidelines
; Source: https://aaronbloomfield.github.io/pdr/book/x86-64bit-asm-chapter.pdf

section .data
var DB 64           ; Declare 8 bits  (1 byte ) - 0.5 word
var2 DW ?           ; Declare 16 bits (2 bytes) - 1  words
var3 DD 3000        ; Declare 32 bits (4 bytes) - 2  words
var4 DQ 64000       ; Declare 64 bits (8 bytes) - 4  words
var5 TIMES 10 DB 1  ; Declare 10 DBs


; Can only add Register Values, max 2 for addressing modes
section .TEXT
mov rax, [rbx]      ; Move bytes in memory at address in EBX --> EAX
mov [var], rbx      ; var in memory <-- EBX
mov rax, [rsi-8]    ; Shift ESI by 8 --> EAX
mov [rsi+rax], cl   ; [ESI+EAX] <-- CL
mov edx, [esi+4*ebx]; Technically legal?

; Size Directive Usage
mov BYTE PTR [ebx],  2
mov WORD PTR [ebx],  2
mov DWORD PTR,[ebx], 2
mov QWORD PTR,[ebx], 2