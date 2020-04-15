# Bitácora E4

### Integrantes:

- Joaquin Camus
- Maria Luisa Claro
- Santiago Muñoz
- Federico Taladriz
- Cristobal Welch


## Explicación funcionamiento componentes

#### `fulladd`:
- In: `a`, `b`, `cin`. Binarios simples.
- Out: `sum`, `cout`. Binarios simples.

Utilizando los módulos xor3, and2 y or2, hace un full adder entre `a` y `b`, retornando el resultado en `sum`. Los carrys in y out son `cin` y `cout`, respectivamente.

#### `ADDER`:
- In: `A`, `B`, vectores de 16 bits cada uno, `cin` binario simple.

- Out: `S`, vector de 16 bits. `cout` binario simple. 

Utilizando el módulo fulladd, suma dos numeros de 16 bits: `A` y `B`.  Retorna el resultado en `S`. Los carrys in y out son `cin` y `cout`, respectivamente.

Este módulo es utilizado para construir el módulo `adder12` de la RAM.

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

#### `SP`
- In: `clock`, `up`, `down`, binarios. 
- Out: `dataout`, vector de 12 bits.

Representa el stack pointer del computador. Si `up` = 1, se aumenta en 1 el registro, mientras que si `down` = 1, se disminuye en 1. El valor del registro en un momento cualquiera se obtiene por la salida `dataout`. 

#### `Decoder_out`
- In: `muxb_out`, vector de 16 bits. `loadout`, binario. 
- Out: `dataout`, vector de 12 bits.

Dependiendo de la señal `muxb_out`, activa el output del display (`muxb_out` = 0), o de los leds (`muxb_out` = 1), sol en caso de que se active el output de la placa (`loadout` = 1). 



## Estructura de instrucciones CPU
Las instrucciones están compuestas por 36 bits:

```
XXXXXXXXXXXXXXXXXXXX YYYYYYYYYYYYYYYY 
```

Donde:
1. Los primeros 20 bits (`X`) entregan la operación a realizar. 
Estos bits se traducen directamente a las señales de salida de la control unit:
    * Los primeros tres bits se utilizan para diferenciar los saltos. Esto, debido a que todos los saltos tienene las mismas señales de control. 
    * Los restantes 17 bits representan las 17 señales de control de salida de la control unit. En orden (de izquierda a derecha), las señales son las siguientes: `Lpc`, `La`, `Lb`, `Sa0`,	`Sa1`, `Sb0`, `Sb1`, `Sop0`, `Sop1`, `Sop2`, `Sadd0`, `Sadd1`, `Sdin`, `Spc`, `W`, `IncSp`, `DecSp`.
2. Los últimos 16 bits (`Y`) representan el literal (de 16 bits) o una dirección (últimos 12 bits), dependiendo de la instrucción que se quiere ejecutar. 

Para el caso de del output, necesitamos una señal extra: `loadout`. Para esto, utilizamos la señal `Lpc`, que es igual a 1 solo para los saltos. En este caso, se utilizan los tres primeros bits de la instrucción para diferenciar los 8 saltos. Entonces, reservamos el caso `Lpc` = 0, en el que el tercer bit de nuestra instrucción (que hasta el momento era igual a 0 para todas las instrucciones) define la señal `loadout`. Por lo tanto, el caso `Lpc` = 0 y `instrucción`(2) = 1, es un output. 

## Tabla de referencia de instrucciones


| Operación |   Argumento(s)   |   Opcode   |
| ------------- | ------------- |------------|
|MOV	|A,B	|00001011000000000000|
| 	|B,A	|00000100110000000000|
|	|A,Lit	|00001011010000000000|
|   |B,Lit	|00000111010000000000|
|   |A,(Dir)	|00001011100000000000|
|   |B,(Dir)	|00000111100000000000|
|   |(Dir),A	|00000000110000010100|
|   |(Dir),B	|00000011000000010100|
|   |A,(B)	|00001011100000100000|
|   |B,(B)	|00000111100000100000|
|   |(B),A	|00000000110000110100|
|   |(B),Lit|	00000011010000110100
|ADD	|A,B	|00001000000000000000|
|   |B,A	|00000100000000000000|
|   |A,Lit	|00001000010000000000|
|   |B,Lit	|00000100010000000000|
|   |A,(Dir)	|00001000100000000000|
|   |B,(Dir)	|00000100100000000000|
|   |(Dir)	|00000000000000010100|
|   |A,(B)	|00001000100000100000|
|   |B,(B)|	00000100100000100000
|SUB	|A,B	|00001000000010000000|
|   |B,A	|00000100000010000000|
|   |A,Lit	|00001000010010000000|
|   |B,Lit	|00000100010010000000|
|   |A,(Dir)	|00001000100010000000|
|   |B,(Dir)	|00000100100010000000|
|   |(Dir)	|00000000000010010100|
|   |A,(B)	|00001000100010100000|
|   |B,(B)|	00000100100010100000
|AND	|A,B	|00001000000100000000|
|    |B,A	|00000100000100000000|
|    |A,Lit	|00001000010100000000|
|    |B,Lit	|00000100010100000000|
|    |A,(Dir)	|00001000100100000000|
|    |B,(Dir)	|00000100100100000000|
|    |(Dir)	|00000000000100010100|
|    |A,(B)	|00001000100100100000|
|    |B,(B)	|00000100100100100000|
|OR	|A,B	|00001000000110000000|
|    |B,A	|00000100000110000000|
|    |A,Lit	|00001000010110000000|
|    |B,Lit	|00000100010110000000|
|    |A,(Dir)	|00001000100110000000|
|    |B,(Dir)	|00000100100110000000|
|    |(Dir)	|00000000000110010100|
|    |A,(B)	|00001000100110100000|
|    |B,(B)|	00000100100110100000
|XOR	|A,B	|00001000001010000000|
|    |B,A	|00000100001010000000|
|    |A,Lit	|00001000011010000000|
|    |B,Lit	|00000100011010000000|
|    |A,(Dir)	|00001000101010000000|
|    |B,(Dir)	|00000100101010000000|
|    |(Dir)	|00000000001010010100|
|    |A,(B)	|00001000101010100000|
|    |B,(B)|	00000100101010100000
|NOT 	|A	|00001000001000000000|
|    |B,A	|00000100001000000000|
|    |(Dir),A	|00000000001000010100|
|    |(B),A|	00000000001000110100
|SHL 	|A	|00001000001100000000|
|    |B,A	|00000100001100000000|
|    |(Dir),A	|00000000001100010100|
|    |(B),A|	00000000001100110100
|SHR 	|A	|00001000001110000000|
|    |B,A	|00000100001110000000|
|    |(Dir),A	|00000000001110010100|
|    |(B),A|	00000000001110110100
|Inc 	|A	|00001000010000000000|
|    |B	|00000101000000000000|
|    |(Dir)	|00000001100000010100|
|    |(B)	|	00000001100000110100
|DEC 	|A	|00001000010010000000|
|CMP 	|A,B	|00000000000010000000|
|    |A,Lit	|00000000010010000000|
|    |A,(Dir)|00000000100010010000|
|    |A,(B)	|	00000000100010110000
|JMP 	|Ins	|00010000000000001000|
|JEQ 	|Ins	|00110000000000001000|
|JNE 	|Ins	|01010000000000001000|
|JGT 	|Ins	|01110000000000001000|
|JLT 	|Ins	|10010000000000001000|
|JGE 	|Ins	|10110000000000001000|
|JLE 	|Ins	|11010000000000001000|
|JCR 	|Ins	|11110000000000001000|
|CALL |	INS	|00010000000001001101|
|RET  |-	|00000000000000000010|
|   |	|	00010000000001000000
|PUSH| 	A	|00000000110001010101|
|   |B	|	00000011000001010101
|POP	|A	|00000000000000000010|
|    |	|00001011100001010000|
|    |B	|00000000000000000010|
|    |	|	00000111100001010000
|NOP	|   	|00000000000000000000|
|IN	|A,Lit| 00001010110000000000|
|	|B,Lit| 00000110110000000000|
|	|(B),Lit| 00000010110000110100|
|OUT|	A,B| 00000010110000110100|
|	|A,(B)| 00100000100000100000|
|	|A,(Dir)| 00100000100000000000|
|	|A,Lit| 00100000100000000000|

	

## Trabajo realizado por cada integrante

- Joaquin Camus : Módulos vhdl, código juego. 
- Maria Luisa Claro : Código programa regular.
- Santiago Muñoz : Assembler.
- Federico Taladriz : Código juego, bitácora. 
- Cristobal Welch : Código programa regular.

Creemos que lo mas dificil fue pensar como sería la nueva estructura de instrucciones. De la entrega pasada, teníamos ocupados todos los bits disponibles para las señales de control, por lo que tuvimos que pensar como definir `OUT`, ya que esta instrucción utilizaba una nueva `load_out`. Esto lo arreglamos utilizando el cuarto bit de nuestra estructura de instrucciones, el que usabamos solo en los saltos (ver tabla con instrucciones). Al usar el caso en que este bit es igual a 0 y utilizando las señales que se utilizaban solo en los saltos, pudimos definir las instucciones nuevas. 

# Assembler

El assembler consiste en 2 archivos
    1. Assembler.py
    2. base.py

El primer archivo Assembler.py tiene 2 clases

1. Writer

Su misión es ser el único con capacidad de escribir sobre el archivo generado rom.vhd.

Tiene 3 funciones:

    1. start(): Se encarga de escribir la parte inicial del archivo rom.vhd, es un string fijo que siempre va y se escribe apenas se instancia la clase Writer

    2. write(): recibe una tupla con el tipo de operación leido por la Clase Reader, busca el opcode correspondiente a la operación en el diccionario del archivo base.py y recibe también la dirección de memoria necesaria por el opcode.

    3. end(): Muy similar a start(), escribe la parte final del código

2. Reader

Su misión es ser el único con capacidad de leer el archivo indicado por el terminal a la hora de correr el assembler


Tiene 6 funciones:

    1. read(): Lee linea por linea el archivo entregado por la terminal y distingue si es parte de la zona DATA o de la zona CODE del código, redirigiendo la informarición a la función corresponndiente

    2. manageData(): Convierte la declaración de variables, tanto de numeros como de arreglos al formato requerido por el Writer para escribirlo satisfactoriamente

    3. manageCode(): Limpia la linea recibida de comentarios, espacios y tabs adicionales no necesarios y si la operación es distinta a RET o NOP, llama a la función prepareWrite()

    4. toBinary(): recibe un número de los formatos soportados por los archivos *.asm con sus letras respectivas y los retorna en binario

    5. prepareWrite(): Identifica el tipo de operación que es y retorna una tupla del estilo: (MOV,A,B) o (ADD,Dir,Lit) que luego el writer busca en el diccionario para encontrar el opcode correspondiente

    6. goGetEm(): Antes de empezar a leer linea por linea identificamos los saltos de linea con sus filas correspondientes en el archivo rom.vhd y guardamos las posiciones en un diccionario que se usa al usar funciones del estilo JMP

El segundo archivo base.py tiene 2 strings y el diccionario de los opcodes

    1. (string) start: string con inicio del codigo .vhd
    2. (string) end: string con el final del código .vhd
    3. newOpCode: es un diccionario con datos guardados de la siguiente forma:

    ("MOV","A","B"): ['00001011000000000000']
    ("ADD","A","(Dir)"): ['00001000100000000000']
    ("ADD","B","Lit"): ['00000100010000000000']

    El Reader, convierte una operación común a algo de la forma del key del diccionario, para que luego el Writer pueda encontrar el opCode correspondiente. El key del diccionario es una tupla y el value es una lista, ya que hay operaciones como el nop que requieren 2 opcodes escritos juntos.


## Reglas del juego grupal

Juego estilo combate naval. El objetivo es destruir los tres barcos del oponente. El flujo de este se describe en los siguientes puntos:
1. El programa inicia mostrando en el display las vidas de cada jugador. Cada jugador tendrá tres vidas al comenzar.
2. El juego inicia con el jugador 1 levantando 3 switches, los cuales representan el lugar de cada uno de sus barcos. Luego, presiona el botón UP para confirmar la distribución de barcos. Finalmente, baja todos los switches para que el jugador 2 distribuya sus barcos.
3. Una vez que el jugador 2 termine de determinar el sitio de cada uno de sus barcos de la misma forma que el jugador 1, el juego comienza.
4. El jugador 1 recibirá la placa con todas las luces leds apagadas. Cada luz representa un sitio al que haya disparado anteriormente. En su turno, al jugador 1 le corresponde levantar un switch, el cual representa una posición enemiga, con el objetivo de derribar un barco enemigo. Para confirmar su jugada, deberá apretar el botón UP. Acá pueden ocurrir dos cosas:

    A. Derribó un barco enemigo. En este caso, el display deberá mostrar las nuevas vidas de los jugadores, disminuyendo en una unidad las del rival. El jugador deberá bajar los switch y ahora es el turno del otro jugador.

    B. Falló el disparo. El jugador deberá bajar los switch y es el turno del otro jugador.
5. En ambos casos, se actualizan los sitios al que ha disparado el jugador y se muestran cuando le corresponda jugar. El juego continúa con esta dinámica hasta que uno de los dos jugadores llegue a las cero vidas, lo que implica que lamentablemente perdió. Una vez que ocurra esto, se encenderán todas las led. 
