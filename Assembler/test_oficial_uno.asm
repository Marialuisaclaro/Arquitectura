DATA:

CODE:

MOV A,11
MOV B,21
PUSH A
PUSH B
POP A
POP B
CALL sum
ADD B,A

end:
JMP end

sum:
 ADD A,B
RET