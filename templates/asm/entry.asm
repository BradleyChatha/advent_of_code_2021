BITS 64

%include "common.asm"
%include "app.asm"

SECTION .data

TIME_FORMAT_STR:    db "__TIME__ = %lld", 0x0A, 0x00
FILE_NAME:          db "input.txt", 0x00
FILE_MODE:          db "rb", 0x00
ERR_FILE:           db "Could not open the input file", 0x0A, 0x00

SECTION .text

global main

extern printf
extern fopen
extern fread
extern fseek
extern ftell
extern fclose
extern getTimeAsUSecs
extern malloc
extern free

extern solution
extern input
extern input_len

main:
    push rbp
    mov rbp, rsp
    ; Registers:
    ;   R12 = Start time
    ;   R13 = End time
    ;   R14 = Holds the file handle

    ; Open the file
    lea rdi, [FILE_NAME]
    lea rsi, [FILE_MODE]
    call fopen

    ; Check it's actually open
    test rax, rax
    jnz .isOpen
    lea rdi, [ERR_FILE]
    call printf
    mov rax, 1
    ret
.isOpen:
    mov r14, rax

    ; Find the file's length
    mov rdi, r14
    mov rsi, 0
    mov rdx, 2 ; SEEK_END
    call fseek

    mov rdi, r14
    call ftell
    mov [input_len], rax

    mov rdi, r14
    mov rsi, 0
    mov rdx, 0 ; SEEK_SET
    call fseek

    ; Allocate the memory for the file
    mov rdi, [input_len]
    call malloc
    mov [input], rax

    ; Read in the file
    mov rdi, [input]
    mov rsi, [input_len]
    mov rdx, 1
    mov rcx, r14
    call fread

    ; Close the file
    mov rdi, r14
    call fclose

    ; Get start time
    call getTimeAsUSecs
    mov r12, rax

    ; Run the solution
    call solution

    ; Get end time
    call getTimeAsUSecs
    mov r13, rax

    ; Find time difference
    sub r13, r12
    mov rsi, r13

    ; Print it out
    lea rdi, [TIME_FORMAT_STR]
    call printf

    ; Be a good programmer
    mov rdi, [input]
    call free

    xor rax, rax
    leave
    ret