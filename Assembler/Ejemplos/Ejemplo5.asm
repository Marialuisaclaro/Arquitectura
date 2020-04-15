DATA:

CODE:

MOV A,11 A=B B=0
MOV B,21   A=B B=15
PUSH A  A=B B=15
PUSH B  A=B B=15
POP A  A=15 B=15
POP B  A=15 B=B
CALL sum  A=20 B=B
ADD B,A  A=20 B=2B
  
end: 
JMP end  
  
sum:  
 ADD A,B  
RET  