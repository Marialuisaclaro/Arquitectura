DATA:
a 5 
b 3 
CODE:
MOV A,1
ADD A,(a)
  ADD A,(b)               // poto
MOV B,A
end:


    DEC A
JMP end

