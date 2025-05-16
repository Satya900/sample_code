.MODEL SMALL
.STACK 100H
.DATA
    matrix1 DB 1,2    ; First 2x2 matrix
            DB 3,4
    matrix2 DB 2,1    ; Second 2x2 matrix
            DB 1,0    ; Added a zero to demonstrate division by zero handling
    result  DB 4 DUP(?) ; Result matrix
    
    msg_add DB 'Addition: $'
    msg_sub DB 10,13,'Subtraction: $'
    msg_mul DB 10,13,'Multiplication: $'
    msg_div DB 10,13,'Division: $'
    newline DB 10,13,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Division (element-wise)
    LEA DX, msg_div
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 4
DIV_LOOP:
    MOV AL, matrix1[SI]    ; Dividend
    MOV BL, matrix2[SI]    ; Divisor
    CMP BL, 0              ; Check for divide by zero
    JE DIV_ZERO_HANDLER    ; Handle divide by zero case

    XOR AH, AH             ; Clear AH for 8-bit division
    DIV BL                 ; AL = Quotient, AH = Remainder
    MOV result[SI], AL     ; Store quotient
    
    ; Print result
    CALL PRINT_RESULT
    JMP CONTINUE_DIV
    
DIV_ZERO_HANDLER:
    ; Print "E" for division by zero error
    MOV DL, 'E'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H

CONTINUE_DIV:
    INC SI
    LOOP DIV_LOOP
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Subroutine to print the result (handles newline after 2 elements)
PRINT_RESULT PROC
    CMP AL, 0                 ; Check if negative
    JNS POSITIVE
    NEG AL                    ; Convert to positive
    MOV DL, '-'               ; Print negative sign
    MOV AH, 02H
    INT 21H

POSITIVE:
    ADD AL, '0'               ; Convert to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    MOV DL, ' '               ; Print space
    INT 21H
    
    MOV AX, SI
    MOV BL, 2
    DIV BL
    CMP AH, 0
    JNE SKIP_NEWLINE
    LEA DX, newline
    MOV AH, 09H
    INT 21H
SKIP_NEWLINE:
    RET
PRINT_RESULT ENDP

END MAIN
