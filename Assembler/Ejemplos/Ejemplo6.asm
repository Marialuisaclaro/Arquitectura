//Arreglos y dir. indirecto

DATA:                           
vector FCh                           A=FC ,B=00       //VECTOR F6->EC, 13
1010b                           A=0A ,B=00
i 0                           A=00 ,B=00
result 0                           A=00 ,B=00
                           
CODE:  
comparar:                        
MOV A, 0	                           A=00 ,B=00
MOV B,(i)   	                           A=00 ,B=00
ADD B,A    	                           A=00 ,B=00
MOV A,(B)  	                           A=FC ,B=00
INC B                             A=FC ,B=01
MOV (i),B                             A=FC ,B=01
                          
XOR B,(B)                           A=FC ,B=F6
MOV A,B                           A=F6 ,B=F6
MOV B,(i)                           A=F6 ,B=01
MOV (vector),A                           A=F6 ,B=01 //CAMBIA VECTOR[0]
MOV B,0                           A=F6 ,B=00
SHL (B),A                           A=F6 ,B=00 //CAMBIA VECTOR[0]
                           
mostrar_arreglo:                           
MOV B,(B)                           A=F6 ,B=EC                   A=FF B=13
MOV A,(vector)                           A=EC ,B=EC              A=EC B=13
CMP A,B                           A= ,B=
JEQ label2                           A= ,B=
                           
fin:                           
JMP fin                         
                           
label2:                           
MOV B,(i)                           A=EC ,B=01
NOT (B),A                           A=EC ,B=01
XOR A,(B)                           A=FF ,B=01
JMP mostrar_arreglo                             