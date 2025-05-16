.MODEL SMALL
.STACK 100H
.DATA
    matrix1 DB 1,2,3    ; First 3x3 matrix
            DB 4,5,6
            DB 7,8,9
            
    matrix2 DB 9,8,7    ; Second 3x3 matrix
            DB 6,5,4
            DB 3,2,1
            
    result  DB 9 DUP(?) ; Result matrix
    
    msg_add DB 'Addition: $'
    msg_sub DB 10,13,'Subtraction: $'
    msg_mul DB 10,13,'Multiplication: $'
    msg_div DB 10,13,'Division: $'
    newline DB 10,13,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ; Addition
    LEA DX, msg_add
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 9
ADD_LOOP:
    MOV AL, matrix1[SI]
    ADD AL, matrix2[SI]
    MOV result[SI], AL
    
    ; Print result
    MOV DL, AL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H
    
    ; New line after every 3 elements
    INC SI
    MOV AX, SI
    MOV BL, 3
    DIV BL
    CMP AH, 0
    JNE SKIP_NEWLINE1
    LEA DX, newline
    MOV AH, 09H
    INT 21H
SKIP_NEWLINE1:
    LOOP ADD_LOOP
    
    ; Subtraction
    LEA DX, msg_sub
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 9
SUB_LOOP:
    MOV AL, matrix1[SI]
    SUB AL, matrix2[SI]
    MOV result[SI], AL
    
    ; Print result
    MOV DL, AL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H
    
    ; New line after every 3 elements
    INC SI
    MOV AX, SI
    MOV BL, 3
    DIV BL
    CMP AH, 0
    JNE SKIP_NEWLINE2
    LEA DX, newline
    MOV AH, 09H
    INT 21H
SKIP_NEWLINE2:
    LOOP SUB_LOOP
    
    ; Multiplication (element-wise)
    LEA DX, msg_mul
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 9
MUL_LOOP:
    MOV AL, matrix1[SI]
    MUL matrix2[SI]
    MOV result[SI], AL
    
    ; Print result
    MOV DL, AL
    ADD DL, '0'
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H
    
    ; New line after every 3 elements
    INC SI
    MOV AX, SI
    MOV BL, 3
    DIV BL
    CMP AH, 0
    JNE SKIP_NEWLINE3
    LEA DX, newline
    MOV AH, 09H
    INT 21H
SKIP_NEWLINE3:
    LOOP MUL_LOOP
    
    ; Division (element-wise)
    LEA DX, msg_div
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 9
DIV_LOOP:
    MOV AL, matrix1[SI]      ; Load element from matrix1
    MOV BL, matrix2[SI]      ; Load element from matrix2
    CMP BL, 0                ; Check if divisor is zero
    JE SKIP_DIV              ; Skip division if divisor is zero
    DIV BL                   ; Divide AL by BL
    MOV result[SI], AL       ; Store result

    ; Print result
    MOV DL, AL
    ADD DL, '0'              ; Convert to ASCII
    MOV AH, 02H
    INT 21H
    MOV DL, ' '
    INT 21H

SKIP_DIV:
    INC SI
    MOV AX, SI
    MOV BL, 3
    DIV BL
    CMP AH, 0
    JNE SKIP_NEWLINE4
    LEA DX, newline
    MOV AH, 09H
    INT 21H
SKIP_NEWLINE4:
    LOOP DIV_LOOP
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
