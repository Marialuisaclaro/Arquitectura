DATA:
var1 1
var2 2
CODE:
MOV A,2
MOV B,2
ADD A,B
ADD A,2
ADD A,B
MOV B,A
ADD A,B
MOV A,B
MOV B,A
MOV A,3
MOV B,3
MOV A,(var1)
MOV B,(var1)
MOV (var1),A
MOV (var1),B
MOV A,(B)
MOV B,(B)
MOV (B),A
MOV (B),3
ADD A,B
ADD B,A
ADD A,3
ADD B,3
ADD A,(var1)
ADD B,(var1)
ADD (var1)
ADD A,(B)
ADD B,(B)
SUB A,B
SUB B,A
SUB A,3
SUB B,3
SUB A,(var1)
SUB B,(var1)
SUB (var1)
SUB A,(B)
SUB B,(B)
AND A,B
AND B,A
AND A,3
AND B,3
AND A,(var1)
AND B,(var1)
AND (var1)
AND A,(B)
AND B,(B)
OR A,B
OR B,A
OR A,3
OR B,3
OR A,(var2)
OR B,(var1)
OR (var1)
OR A,(B)
OR B,(B)
XOR A,B
XOR B,A
XOR A,3
XOR B,3
XOR A,(var1)
XOR B,(var1)
XOR (var1)
XOR A,(B)
XOR B,(B)
NOT A
NOT B,A
NOT (var1),A
NOT (B),A
SHL A
SHL B,A
SHL (var1),A
SHL (B),A
SHR A
SHR B,A
SHR (var1),A
SHR (B),A
Inc A
Inc B
Inc (var2)
Inc (B)
DEC A
CMP A,B
CMP A,3
CMP A,(var2)
CMP A,(B)
JMP end
JEQ end
JNE end
JGT end
JLT end
JGE end
JLE end
JCR end
CALL end
RET
RET
PUSH A
PUSH B
POP A
POP A
POP B
POP B
NOP
end: