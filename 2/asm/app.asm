SECTION .data

PRINT_S1: db "__S1__ = %d", 0x0A, 0
PRINT_S2: db "__S2__ = %d", 0x0A, 0

SECTION .text

; Sets AL to the amount
; Updates RSI and RDI
%macro nextDirectionAndAmount 0
    lodsb
    dec rdi
    cmp al, 'f'
    je .forward_
    cmp al, 'd'
    je .down_
.up_:
    add rsi, 2
    lodsb
    and al, 0x0F
    inc rsi
    sub rdi, 4
    jmp .up
.forward_:
    add rsi, 7
    lodsb
    and al, 0x0F
    inc rsi
    sub rdi, 9
    jmp .forward
.down_:
    add rsi, 4
    lodsb
    and al, 0x0F
    inc rsi
    sub rdi, 6
    jmp .down
%endmacro

solution:
    push rbp
    mov rbp, rsp

    call s1
    lea rdi, [PRINT_S1]
    mov rsi, rax
    call printf

    call s2
    lea rdi, [PRINT_S2]
    mov rsi, rax
    call printf

    leave
    ret

s1:
    ; REGISTERS
    ;   RSI = Pointer into input
    ;   RDI = Chars left to read
    ;   AL  = amount
    ;   R10 = Vert
    ;   R11 = Horiz
    ;   RAX = Result

    mov rsi, [input]
    mov rdi, [input_len]
    xor r10, r10
    xor r11, r11
    xor rax, rax

.loop:
    nextDirectionAndAmount
.up:
    sub r10, rax
    jmp .continue
.down:
    add r10, rax
    jmp .continue
.forward:
    add r11, rax
.continue:
    cmp rdi, 1
    jge .loop
.end:
    mov rax, r10
    mul r11
    ret

s2:
    ; REGISTERS
    ;   RSI = Pointer into input
    ;   RDI = Chars left to read
    ;   AL  = amount
    ;   R9  = Aim
    ;   R10 = Vert
    ;   R11 = Horiz
    ;   RAX = Result

    mov rsi, [input]
    mov rdi, [input_len]
    xor r9, r9
    xor r10, r10
    xor r11, r11
    xor rax, rax

.loop:
    nextDirectionAndAmount
.up:
    sub r9, rax
    jmp .continue
.down:
    add r9, rax
    jmp .continue
.forward:
    add r11, rax
    mul r9
    add r10, rax
    xor rax, rax
.continue:
    cmp rdi, 1
    jge .loop
.end:
    mov rax, r10
    mul r11
    ret