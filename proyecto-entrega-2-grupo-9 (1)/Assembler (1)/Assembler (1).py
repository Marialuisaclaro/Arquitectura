import sys
from base import newOpCode, romBase, romEnd

# TODO General
# Tipos de números (1d, 1h, 1b)
# Soportar Arreglos
# Soportar (0) tanto comp primero como segundo argumento

'''
    Se encarga de escribir en el archivo ROM.vhd
'''
class Writer:
    def __init__(self):
        # Strings
        self.romBase = romBase
        self.romEnd = romEnd
        self.linesWritten = 0
        # Dictionary opcode((MOV,A,B))
        self.opcode = newOpCode
        self.file = open("rom.vhd", 'w')
        self.start()

    '''
        Escribe la sección inicial de la ROM
    '''
    def start(self):
        print(romBase, file=self.file)

    '''
        Escribe linea por linea
    '''
    def write(self, tuple, adressList, end):
        
        if not (end):
            for i in (self.opcode[tuple]):
                print('"{}{}", --{}'.format(i, adressList, tuple), file=self.file)
                self.linesWritten += 1
        else:
            for i in (self.opcode[tuple]):
                print('"{}{}", --{}'.format(i, adressList, tuple), file=self.file)
                self.linesWritten += 1
    '''
        Escribe la sección final de la ROM
    '''
    def end(self):
        # Imprimir el final
        while (self.linesWritten < 4096):
            print('"000000000000000000000000000000000000", --{}'.format("blank"), file=self.file)
            self.linesWritten += 1
            if (self.linesWritten == 4095):
                print('"000000000000000000000000000000000000" --{}'.format("blank"), file=self.file)
                self.linesWritten += 1
        print(romEnd, file=self.file)
        self.file.close()


class Reader:
    def __init__(self):
        self.file = open("test_oficial_uno.asm", 'r+')
        self.lines = self.file.read().splitlines()
        print(f"Lines: {self.lines}")
        self.variables = {}
        self.dirBase = 0
        self.lineJumps = {}
        # Create Writer
        self.writer = Writer()
        # Iniciamos lectura
        self.goGetEm()
        self.read()

    def read(self):
        mode = "init"
        for i in range(len(self.lines)):
            if ("DATA:" in self.lines[i]):
                mode = "data"
                continue
            elif ("CODE:" in self.lines[i]):
                mode = "code"
                continue
            if (mode == "data"):
                self.manageData(i)
            elif mode == "code":
                print("en Code")
                isEnd = 0
                if (i == len(self.lines) - 1):
                    isEnd = 1
                self.manageCode(i, isEnd)
        # Terminar de escribir el vhd
        self.writer.end()

    # Genera los [MOV A,lit; MOV (dir),A] iniciales
    # TODO
    # Manejar tipos de números input
    def manageData(self, pos):
        linea = self.lines[pos]
        if (linea.isspace() or linea == ''):
            return
        if ("//" in linea):
            linea = linea[:linea.find("//")].strip().split()
            #linea[1] = ("".join(linea[1:])).replace(" ", "")
        else:
            linea = linea.strip().split()
            #linea[1] = ("".join(linea[1:])).replace(" ", "")
        print("linea", linea)

        if (len(linea) != 1):
            # Generar (Dir)
            self.variables[linea[0]] = str(self.dirBase).zfill(16)
            # MOV(A,Lit)
            self.writer.write(('MOV','A', 'Lit'), self.to_binary(linea[1]), 0)
            # MOV((Dir),A)
            self.writer.write(('MOV','(Dir)','A'), self.to_binary(self.variables[linea[0]]), 0)
        # Arreglos
        else:
            # MOV(A,Lit)
            self.writer.write(('MOV','A', 'Lit'), self.to_binary(linea[0]), 0)  
            # MOV((Dir),A)  
            adr = self.to_binary(str(self.dirBase).zfill(16))
            self.writer.write(('MOV','(Dir)','A'), adr, 0)

        self.dirBase += 1
        # Leemos lineas de codigo

    def manageCode(self, pos, isEnd):
        # Separa entre comando y argumentos
        # Manejar Tabs y comentarios
        linea = self.lines[pos]
        print("linea2", linea)

        if (linea.isspace() or linea == ''):
            return

        if ("//" in linea):
            linea = linea[:linea.find("//")].strip().split()
            #linea[1] = ("".join(linea[1:])).replace(" ", "")
        else:
            linea = linea.strip().split()
            #linea[1] = ("".join(linea[1:])).replace(" ", "")
        print("linea", linea)

        # Check si es una linea posicional [start]
        if(":" in linea[0]):
            return

        # Ret o Nop
        if (len(linea) == 1):
            self.writer.write(linea[0], "0000000000000000", isEnd)

        # Todos los demás
        else:
            linea[1] = ("".join(linea[1:])).replace(" ", "")
            argType = self.prepareWrite(linea[0], linea[1])
            if (len(argType[1]) > 0):
                self.writer.write(argType[0], argType[1][0], isEnd)
            else:
                self.writer.write(argType[0], "0000000000000000", isEnd)


    '''
    Retorna una tupla con los tipos finales para entregarle al dicti inmediatamente
    Example:
        A,B
        A,2
        B,2
        variable1,2
        (B),3
    '''
    def to_binary(self, number):
        print(f'Number: {number}')
        if 'b' in number:
            binary_number = str(number[:-1].zfill(16))
        elif 'h' in number:
            binary_number = str(bin(int(number[:-1], 16))[2:].zfill(16))
        elif 'd' in number:
            binary_number = str(bin(int(number[:-1]))[2:].zfill(16))
        elif number.isnumeric():
            binary_number = str(bin(int(number))[2:].zfill(16))
        else:
            pass
        return binary_number
    
    def prepareWrite(self, operation, atributes):
        arguments = atributes.strip().split(',')
        readyTuple = [operation]
        valueList = []
        for j in arguments:

            # es A, B, (B)
            if ("A" == j or "B" == j):
                readyTuple.append(j)
                if (readyTuple[0] == "INC" or readyTuple[0] == "DEC"):
                    print("Entre a INC")
                    valueList.append("0000000000000001")
            
            elif (j == "(B)"):
                readyTuple.append(j)

            # es número
            #elif (j.isnumeric()):
            #    # TODO Add Welch Function and change numeric
            #    readyTuple.append("Lit")
            #    valueList.append( (bin(int(j))[2:]).zfill(16) )

            # es Variable
            elif (j[0] == '(' and j[-1] == ')'):
                #j[1:-1] in self.variables):
                readyTuple.append("(Dir)")
                valueList.append(self.to_binary(self.variables[j[1:-1]]))
            
            elif (j in self.variables):
                readyTuple.append("Lit")
                valueList.append(self.variables[j])


            # TODO
            # (0)
            #elif ("(" in j):
                # Revisar si es primer o segundo argumento
                # print(j[1:-1])
                # print(self.variables)
                # key = list(self.variables.keys())[int(j[1:-1])]
                # readyTuple.append("(Dir)")
                # readyTuple.append(self.variables[key])
            #    pass
            
            # es un salto de linea
            elif (j in self.lineJumps):
                readyTuple.append("INS")
                valueList.append(self.lineJumps[j])
            
            else:
                readyTuple.append("Lit")
                valueList.append(self.to_binary(j))

        print("readyTuple", readyTuple)
        print(f"Line Jumps: {self.lineJumps}")
        return [tuple(readyTuple), valueList]
        

    def goGetEm(self):
        linesWritenInitial = 0
        mode = 0
        for i in self.lines:
            if (i.isspace() or i == ''):
                continue
            if ("DATA" in i.upper()):     # i.upper() == "DATA:"
                mode = 1

            elif ("CODE" in i.upper()):      # i.upper() == "CODE:"
                mode = 2
            
            elif (mode == 1):
                linesWritenInitial += 2

            # Entramos a Code
            elif (mode == 2):
                linesWritenInitial += 1
                if ("RET" in i):
                    linesWritenInitial += 1
                elif ("POP" in i):
                    linesWritenInitial += 1
                elif (":" in i):
                    print(f'Entré con Mode 2')
                    linesWritenInitial -= 1
                    self.lineJumps[i[:-1]] = str(bin(linesWritenInitial))[2:].zfill(16)


if(__name__ == "__main__"):
    read = Reader()
