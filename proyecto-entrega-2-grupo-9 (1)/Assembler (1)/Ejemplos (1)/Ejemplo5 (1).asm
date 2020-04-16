DATA:
varA 8
varB 3
CODE:
MOV A,(varB)
NOT (varB),A
INC (varB)
suma:
MOV A,(varA)
end:
NOP
JMP end