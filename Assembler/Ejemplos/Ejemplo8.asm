DATA:

 arr	5 
  	Ah
	1
	3
	8
	5
 n	6
 r	0 

CODE:			// Sumar arreglo

MOV B,arr		// Puntero arr a B

siguiente:
 MOV A,(n)		// Restantes a A
 CMP A,0		// Si Restantes == 0
 JEQ end		// Terminar
 DEC A			// Restantes --
 MOV (n),A		// Guardar Restantes
 MOV A,(r)		// Resultado a A
 ADD A,(B)		// Resultado + Arr[i] a A
 MOV (r),A		// Guardar Resultado
 INC B			// Puntero en B ++
 JMP siguiente 		// Siguiente

end:
 MOV A,(r)		// Resultado a A
 JMP end