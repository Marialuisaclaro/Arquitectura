DATA:
CODE:
MOV A,7
MOV B,1
CALL resta	
fin:
JMP fin
suma:	
XOR B,A
PUSH B
XOR B,A
AND A,B
POP B
CMP A,0
JEQ suma_fin
SHL A
CALL suma
suma_fin:	
MOV A,B
RET
comp2:
NOT A
INC A
RET
resta:		
PUSH A
MOV A,B
CALL comp2
MOV B,A
POP A
CALL suma
RET