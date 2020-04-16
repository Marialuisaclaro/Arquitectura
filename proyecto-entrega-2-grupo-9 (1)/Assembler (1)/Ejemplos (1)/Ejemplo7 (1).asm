DATA:
CODE:
MOV B,0
MOV A,8000h
MOV (B),A
shl_r:
MOV A,0
OR A,(B)
SHL (B),A
JCR shl_r_carry
JMP shl_r_end
shl_r_carry:		
INC (B)
shl_r_end:		
JMP shl_r