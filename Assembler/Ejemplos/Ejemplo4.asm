DATA:
a E5h
b B3h
bits 0b
CODE:
MOV A, ( a)
AND A , ( 1d )
JMP loop
bit:
INC  (2h)
loop:
CMP A ,0b
JEQ  end
SHR A
JCR  bit
JMP  loop
end:
MOV A,(10b)
JMP end


