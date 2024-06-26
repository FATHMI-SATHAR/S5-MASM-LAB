DATA SEGMENT
	MSG1 DB 10,13,'ENTER  THE STRING:$'
	STR1 DB 100,0,100 dup(0)
	LEN1 DW 0000H
	MSG2 DB 10,13,'SUBSTRING TO BE REPLACED IS: $'
	STR2 DB 20,0,20 DUP(0)
	LEN2 DW 0000H
	MSG3 DB 10,13,'REPLACE WITH:$'
	STR3 DB 20,0,20 DUP(0)
	LEN3 DW 0000H
	MSG4 DB 10,13,'OUTPUT STRING IS: $'
	DATA ENDS

DISPLAY MACRO MSG
    MOV AH,09
    LEA DX,MSG
    INT 21H
ENDM  
 
CODE SEGMENT
             ASSUME CS:CODE,DS:DATA,ES:DATA

START: MOV AX,DATA
	MOV DS,AX
	MOV ES,AX

DISPLAY MSG1

LEA DX,STR1
MOV AH,0AH
INT 21H
MOV AL,[STR1+1]
MOV BX,OFFSET LEN1      
MOV BYTE PTR [BX],AL

DISPLAY MSG2
LEA DX,STR2
MOV AH,0AH
INT 21H
MOV AL,[STR2+1]
MOV BX,OFFSET LEN2      
MOV BYTE PTR [BX],AL 

DISPLAY MSG3
LEA DX,STR3
MOV AH,0AH
INT 21H
MOV AL,[STR3+1]
MOV BX,OFFSET LEN3      
MOV BYTE PTR [BX],AL
  
LEA SI,STR1+2
MOV CX,LEN1
DISPLAY MSG4

LEA DI,STR2+2
MOV BX,LEN2

 PUSH SI
 PUSH CX

 UP:MOV AL,[SI]
 L3:MOV AH,[DI]
    CMP AH,AL
    JZ L2

    POP CX
    POP SI
    LEA DI,STR2+2
    MOV BX,LEN2
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    DEC CX
    PUSH SI
    PUSH CX
    CMP CX,0000
    JNZ UP
    JZ LAST

 L2:DEC BX
    PUSH SI
    PUSH CX
    MOV AX,LEN2
    CMP BX,AX
    JNZ L4
 L4:
    INC SI
    INC DI
    CMP BX,0000
    JZ L1
     DEC CX 
    JNZ UP
 L1:LEA DI,STR3+2
    MOV BX,LEN3
 L9:MOV DL,[DI]
    MOV AH,02H
    INT 21H
    INC DI
    DEC BX
    JNZ L9 
    LEA DI,STR2+2
    MOV BX,LEN2
    PUSH SI
    PUSH CX
    JMP UP
LAST:
    MOV AH,4CH
    INT 21H
CODE ENDS
END START
