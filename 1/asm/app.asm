SECTION .data

PRINT_S1: db "__S1__ = %d", 0x0A, 0
PRINT_S2: db "__S2__ = %d", 0x0A, 0

SECTION .text

solution:
    push rbp
    mov rbp, rsp

    call s1
    call s2

    leave
    ret

s1:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    ; REGISTERS
    ;   RSI = Pointer into input
    ;   RCX = Chars left in input
    ;   R12 = Last value
    ;   R13 = Counter
    ;   R8  = Misc maths

    mov rsi, [input]
    mov rcx, [input_len]
    xor rax, rax
    xor r8, r8
    xor r13, r13

    call _parseDigits
    mov r12, rax

.loop:
    call _parseDigits
    cmp r12d, eax
    sets r8b
    add r13, r8

    mov r12, rax
    cmp rcx, 1
    jge .loop
.end:

    lea rdi, [PRINT_S1]
    mov rsi, r13
    call printf

    pop r13
    pop r12
    leave
    ret

s2:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

    ; REGISTERS
    ;   RSI = Pointer into input
    ;   RCX = Chars left in input
    ;   R12 = Last Last Last value
    ;   R13 = Last Last Value
    ;   R14 = Last Value
    ;   R15 = Counter
    ;   R8  = Misc maths
    ;   R9  = Sum of values
    ;   R10 = Last sum of values

    mov rsi, [input]
    mov rcx, [input_len]
    xor rax, rax
    xor r8, r8
    xor r15, r15

    call _parseDigits
    mov r12, rax

    call _parseDigits
    mov r13, rax

    call _parseDigits
    mov r14, rax

    xor r9, r9
    add r9, r12
    add r9, r13
    add r9, r14
    mov r10, r9

.loop:
    mov r12, r13
    mov r13, r14

    push r10
    call _parseDigits
    pop r10
    mov r14, rax

    xor r9, r9
    add r9, r12
    add r9, r13
    add r9, r14

    cmp r10, r9
    sets r8b
    add r15, r8

    mov r10, r9
    cmp rcx, 1
    jge .loop
.end:

    lea rdi, [PRINT_S2]
    mov rsi, r15
    call printf

    pop r15
    pop r14
    pop r13
    pop r12
    leave
    ret

; Clobbers rax, rdx, r9, r10, r11
; Updates rcx and rsi
_parseDigits:
    sub rcx, 4
    lodsd ; Load the next 3 digits, as well as either the new line or 4th digit, into EAX
    and eax, 0x0F0F0F0F ; Fancy way of converting from ASCII into a number
    mov edx, eax ; We'll be using EDX for some destructive ops

    ; Two possible branches: We have a 4 digit number, or a 3 digit number with a new line
    shr eax, 24
    cmp eax, 0x0A
    mov eax, 0
    je .newLine
.noNewLine: ; edx = 11223344
    ; 4th
    xor r9, r9
    xor r10,r10
    xor r11,r11
    mov r9b, dl
    mov r10b, dl
    mov r11b, dl
    shl r9d, 10  ; x1024
    shl r10d, 5 ; x32
    shl r11d, 3 ; x8
    sub r10d, r11d ; x24
    sub r9d, r10d ; x1000
    add eax, r9d
    shr edx, 8
    dec rcx
    inc rsi
.newLine: ; edx = \n112233
    ; 3rd
    xor r9, r9
    xor r10,r10
    xor r11,r11
    mov r9b, dl
    mov r10b, dl
    mov r11b, dl
    shl r9d, 2 ; x4
    shl r10d, 6 ; x64
    shl r11d, 5 ; x32
    add r9d, r10d
    add r9d, r11d
    add eax, r9d

    ; 2nd
    shr edx, 8
    xor r10,r10
    xor r11,r11
    mov r10b, dl
    mov r11b, dl
    shl r10d, 3 ; x8
    shl r11d, 1 ; x2
    add r10d, r11d ; x10
    add eax, r10d

    ; 1st
    shr edx, 8
    and edx, 0xFF
    add eax, edx

    ret