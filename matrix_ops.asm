.MODEL SMALL
.STACK 100H
.DATA
    matrix1 DB 1,2    ; First matrix
            DB 3,4
    matrix2 DB 2,1    ; Second matrix
            DB 1,2
    result  DB 4 DUP(?) ; Result matrix
    
    msg_add DB 'Addition: $'
    msg_sub DB 10,13,'Subtraction: $'
    msg_mul DB 10,13,'Multiplication: $'
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
    MOV CX, 4
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
    
    INC SI
    LOOP ADD_LOOP
    
    ; Subtraction
    LEA DX, msg_sub
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 4
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
    
    INC SI
    LOOP SUB_LOOP
    
    ; Multiplication (element-wise)
    LEA DX, msg_mul
    MOV AH, 09H
    INT 21H
    
    MOV SI, 0
    MOV CX, 4
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
    
    INC SI
    LOOP MUL_LOOP
    
    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN