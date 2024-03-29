; Abenoja, Amelia Joyce L.      S17
; Labarrete, Lance Desmond D.  S17

; --------------------------

%include "io64.inc"

section .text
global main
main:
    ; Ask for user input, an unsigned decimal
    ; Maximum num: 18446744073709551615 = (18.x * 1018)
    ; Minimum num: 1
    ; 48 = 0
    ; 49 = 1
    ; 57 = 9
    PRINT_STRING "Input: "
    GET_UDEC 8, RAX
    
    ; Check for negative input
    CMP RAX, 1
    JL ERROR_NEGATIVE
    
    ; Copy the original input to RBX
    MOV RBX, RAX
    
    PRINT_STRING "Sequence: "

    ; Continues sequence until the number is 1
SEQUENCE_LOOP:
    ; Output the current term in the sequence
    PRINT_DEC 8, RBX
    
    ; Check if the current term is 1
    CMP RBX, 1
    JE FINALLY  ; if 1, jump to finally
    
    ; If the current term is not 1, print the comma
    PRINT_STRING ", "
    
    ; Check if the current term is even
    MOV RAX, RBX
    MOV RCX, 2
    MOV RDX, 0
    DIV RCX
    
    CMP RDX, 0
    JE EVEN  ; if even, jump to even section
    ; Else, it goes directly to ODD
    
            
ODD:
    ; triple it and add 1
    MOV RAX, RBX
    MOV RCX, 3
    MOV RDX, 0  ; contains the higher order of 64-bits
    MUL RCX
    INC RAX
    
    ; Update RBX to the new term
    MOV RBX, RAX
    JMP SEQUENCE_LOOP  ; Continue with the next term in the sequence


EVEN:
    ; if even, divide it by two
    MOV RAX, RBX
    SHR RAX, 1
    
    ; Update RBX to the new term
    MOV RBX, RAX
    JMP SEQUENCE_LOOP  ; Continue with the next term in the sequence


FINALLY: 
    NEWLINE
    ; Prompt the user whether to continue
    PRINT_STRING "Do you want to continue (Y/N)? "
    GET_CHAR RDX    ; For 'enter' key 
    GET_CHAR RAX
    CMP RAX, 'Y'
    JE main         ; if 'Y', jump to start (input prompt)

    CMP RAX, 'N'    ; if 'N', jump to exit the program
    JE EXIT
    
    JMP ERROR_INVALID

ERROR_NEGATIVE:
    ; Print error message for negative input
    NEWLINE
    PRINT_STRING "Error: negative number input"
    JMP FINALLY

ERROR_INVALID:
    ; Print error message for invalid choice in continuing the program
    NEWLINE
    PRINT_STRING "Error: Invalid input"
    JMP FINALLY
    
EXIT: 
    ; Exit the program
    xor rax, rax
    ret
