# Entrega 2, Grupo 9

## Integrantes:

- Joaquin Camus
- Maria Luisa Claro
- Santiago Muñoz
- Federico Taladriz
- Cristobal Welch


# Funcionamiento de cada componente

#### `fulladd`:
- In: `a`, `b`, `cin`. Binarios simples.
- Out: `sum`, `cout`. Binarios simples.

Utilizando los módulos xor3, and2 y or2, hace un full adder entre `a` y `b`, retornando el resultado en `sum`. Los carrys in y out son `cin` y `cout`, respectivamente.

#### `ADDER`:
- In: `A`, `B`, vectores de 16 bits cada uno, `cin` binario simple.

- Out: `S`, vector de 16 bits. `cout` binario simple. 

Utilizando el módulo fulladd, suma dos numeros de 16 bits: `A` y `B`.  Retorna el resultado en `S`. Los carrys in y out son `cin` y `cout`, respectivamente.

#### `SUBER`:
- In: `A`, `B`, vectores de 16 bits cada uno, `cin` binario simple.

- Out: `S`, vector de 16 bits. `cout` binario simple. 

Suma dos numeros de 16 bits: `A` y `B`.  Retorna el resultado en `sum`. Los carrys in y out son `cin` y `cout`, respectivamente. Para hacer la resta, en primer lugar saca el negativo del segundo número con complemento a 2, y luego utiliza el módulo ADDER para hacer la suma. 

#### `RAM`:
- In: `clock`, `write`, binarios simples. `address`, vector de 12 bits.  `datain`, vector de 16 bits.

- Out: `dataout`, vector de 16 bits.

Representa la RAM del computador. Si la entrada `write` es 1, se escribe y si es 0 se lee. Se ingresa la dirección por el verctor `address`. En en el caso de lectura, en esta dirección se escribe el vector `datain` y si está en modo escritura se entrega el valor guardado en esta dirección en `dataout`. 

#### `ROM`:
- In: `address`, vector de 12 bits. 

- Out: `dataout`, vector de 36 bits.

Representa la ROM del computador. Por la entrada `address` se entrega la dirección que se quiere leer y por `dataout` se entrega la instrucción almacenada en esa dirección. 

#### `program_counter`
- In: `clock`, `load`, binarios simples. `data_in`, vector de 12 bits. 
- Out: `data_out`, vector de 12 bits. 

Representa el program counter del computador. El bit `load` define si se está en modo incremento (0) o en modo carga (1), todo en tiempos marcado por la señal de la entrada `clock`. La entrada `data_in` se usa para cargar la dirección de una instrucción (subrutinas, saltos, etc). La entrada `data_out` entrega la dirección de la instrucción que se va a leer ahora en la ROM. 

#### `MUX2`
- In: `A0`, `A1`, `B0`. Binarios. 
- Out: `S0`, Binario.

Representa un Multiplexor de 2 entradas. Dependiendo de la señal de control `B0`, deja pasar la señal `A0` (`B0` = 0) o `A1` (`B1` = 1) en la señal `S0`. 

Este módulo se utiliza para la construcción del módulo `MUX4`, el que se utiliza para construir `MUX8`, el que finalmente se utiliza para construir `MUX16`.

#### `control_unit`
- In: `Instruction`, vector de 20 bits. `Status`, vector de 3 bits. 
- Out: `enableA`, `enableB`, `loadPC`, `W`, binarios. `selA`, `selB`, vectores de 2 bits. `selALU`, vector de 3 bits. 

Representa la control unit de nuestro computador. Decodifica la instrucción de 20 bits entregada por la ROM, y en conjunto con los status codes entregados por el registro `Status`, entrega las señales de control a las componentes correspondientes para la ejecución del tiempo actual del clock. 

 # Trabajo realizado por cada integrante

- Joaquin Camus : Módulo principal, acople de componentes, Multiplexores. 
- Maria Luisa Claro : Shifter, Control Unit.
- Santiago Muñoz : ROM, Control Unit, diccionario ROM.
- Federico Taladriz : Adder y substractor, Documentación de módulos, código multiplicación.
- Cristobal Welch : Program counter.

 # Código Assembly multiplicación

```
DATA:
	var1 3
	var2 4
	res 0
	i 0

CODE:
	start: 
		MOV A, (var1)
		MOV B, (i)
		CMP A, B
		JEQ end
		MOV A,(res)
		ADD A,(var2)
		MOV (res),A
		MOV A,(i)
		ADD A,1
		MOV (i),A
		JMP start

	end: 
		JMP end
```
# Estructura de instrucciones de la CPU

La instrucción está compuesta de 36 bits:

```
XXXXXX YYYYYYYYYYYYYYYY 00000000000000 
```

* 6 bits (`X`), que representan la operación a realizar. 
* 16 bits (`Y`) de literal o dirección. En el caso de que se incluya un literal en la instrucción, se ocupan los 16 bits. En el caso de que se incluya una dirección, se ocupan los primeros 12 bits y los otros 4 se rellenan con ceros.
* 14 bits en cero.

# Tabla de instrucciones

| Instrucción   |    Operando   |   Opcode   |
| ------------- | ------------- |------------|
|MOV|	A,B	    |0          |
|MOV|	B,A	    |1       |
|MOV|	A,Lit	|10      |
|MOV|	B,Lit	|11      |
|MOV|	A,(Dir)	|100     |
|MOV|	B,(Dir)	|101     |
|MOV|	(Dir),A	|110     |
|MOV|	(Dir),B	|111     |
|ADD|	A,B	    |1000       | 
|ADD|	B,A	    |1001       | 
|ADD|	A,Lit	|1010       | 
|ADD|	B,Lit	|1011       | 
|ADD|	A,(Dir)	|1100       | 
|ADD|	B,(Dir)	|1101       | 
|ADD|	(Dir)	|1110       | 
|SUB|	A,B	    |1111       | 
|SUB|	B,A	    |10000      | 
|SUB|	A,Lit	|10001      | 
|SUB|	B,Lit	|10010      | 
|SUB|	A,(Dir)	|10011      | 
|SUB|	B,(Dir)	|10100      | 
|SUB|	(Dir)	|10101      | 
|AND|	A,B	    |10110      | 
|AND|	B,A	    |10111      | 
|AND|	A,Lit	|11000      | 
|AND|	B,Lit	|11001      | 
|AND|	A,(Dir)	|11010      | 
|AND|	B,(Dir)	|11011      | 
|AND|	(Dir)	|11100      | 
|OR	|   A,B	    |11101      | 
|OR	|   B,A	    |11110      | 
|OR	|   A,Lit	|11111      | 
|OR	|   B,Lit	|100000|
|OR	|   A,(Dir)	|100001|
|OR	|   B,(Dir)	|100010|
|OR	|   (Dir)	|100011|
|XOR|	A,B	    |100100|
|XOR|	B,A	    |100101|
|XOR|	A,Lit	|100110|
|XOR|	B,Lit	|100111|
|XOR|	A,(Dir)	|101000|
|XOR|	B,(Dir)	|101001|
|XOR|	(Dir)	|101010|
|NOT|	A	    |101011|
|NOT|	B,A	    |101100|
|NOT|	(Dir),A	|101101|
|SHL|	A	    |101110|
|SHL|	B,A	    |101111|
|SHL|	(Dir),A	|110000|
|SHR|	A	    |110001|
|SHR|	B,A	    |110010|
|SHR|	(Dir),A	|110011|
|Inc|	A	    |110100|
|Inc|	B	    |110101|
|Inc|	(Dir)	|110110|
|DEC|	A	    |110111|
|CMP|	A,B	    |111000|
|CMP|	A,Lit	|111001|
|CMP|	A,(Dir)	|111010|
|JMP|	Ins	    |111011|
|JEQ|	Ins	    |111100|
|JNE|	Ins	    |111101|
|NOP|	-	    |111110|


# Cámbios de nuestro computador respecto al diagrama entregado en el enunciado

Al MuxA le agregamos dos entradas: una de la RAM y otra de la ROM. Por otro lado, le sacamos la entrada de valor 1.
