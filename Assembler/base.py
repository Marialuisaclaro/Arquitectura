romBase = '''library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port (
        address   : in  std_logic_vector(11 downto 0);
        dataout   : out std_logic_vector(35 downto 0)
          );
end ROM; 

architecture Behavioral of ROM is

type memory_array is array (0 to ((2 ** 12) - 1) ) of std_logic_vector (35 downto 0); 

signal memory : memory_array:= (
'''

romEnd = '''); 
begin
   dataout <= memory(to_integer(unsigned(address))); 
end Behavioral; 
'''

newOpCode = {
("MOV","A","B"): ['00001011000000000000'],
("MOV","B","A"): ['00000100110000000000'],
("MOV","A","Lit"): ['00001011010000000000'],
("MOV","B","Lit"): ['00000111010000000000'],
("MOV","A","(Dir)"): ['00001011100000000000'],
("MOV","B","(Dir)"): ['00000111100000000000'],
("MOV","(Dir)","A"): ['00000000110000010100'],
("MOV","(Dir)","B"): ['00000011000000010100'],
("MOV","A","(B)"): ['00001011100000100000'],
("MOV","B","(B)"): ['00000111100000100000'],
("MOV","(B)","A"): ['00000000110000110100'],
("MOV","(B)","Lit"): ['00000011010000110100'],
("ADD","A","B"): ['00001000000000000000'],
("ADD","B","A"): ['00000100000000000000'],
("ADD","A","Lit"): ['00001000010000000000'],
("ADD","B","Lit"): ['00000100010000000000'],
("ADD","A","(Dir)"): ['00001000100000000000'],
("ADD","B","(Dir)"): ['00000100100000000000'],
("ADD","(Dir)"): ['00000000000000010100'],
("ADD","A","(B)"): ['00001000100000100000'],
("ADD","B","(B)"): ['00000100100000100000'],
("SUB","A","B"): ['00001000000010000000'],
("SUB","B","A"): ['00000100000010000000'],
("SUB","A","Lit"): ['00001000010010000000'],
("SUB","B","Lit"): ['00000100010010000000'],
("SUB","A","(Dir)"): ['00001000100010000000'],
("SUB","B","(Dir)"): ['00000100100010000000'],
("SUB","(Dir)"): ['00000000000010010100'],
("SUB","A","(B)"): ['00001000100010100000'],
("SUB","B","(B)"): ['00000100100010100000'],
("AND","A","B"): ['00001000000100000000'],
("AND","B","A"): ['00000100000100000000'],
("AND","A","Lit"): ['00001000010100000000'],
("AND","B","Lit"): ['00000100010100000000'],
("AND","A","(Dir)"): ['00001000100100000000'],
("AND","B","(Dir)"): ['00000100100100000000'],
("AND","(Dir)"): ['00000000000100010100'],
("AND","A","(B)"): ['00001000100100100000'],
("AND","B","(B)"): ['00000100100100100000'],
("OR","A","B"): ['00001000000110000000'],
("OR","B","A"): ['00000100000110000000'],
("OR","A","Lit"): ['00001000010110000000'],
("OR","B","Lit"): ['00000100010110000000'],
("OR","A","(Dir)"): ['00001000100110000000'],
("OR","B","(Dir)"): ['00000100100110000000'],
("OR","(Dir)"): ['00000000000110010100'],
("OR","A","(B)"): ['00001000100110100000'],
("OR","B","(B)"): ['00000100100110100000'],
("XOR","A","B"): ['00001000001010000000'],
("XOR","B","A"): ['00000100001010000000'],
("XOR","A","Lit"): ['00001000011010000000'],
("XOR","B","Lit"): ['00000100011010000000'],
("XOR","A","(Dir)"): ['00001000101010000000'],
("XOR","B","(Dir)"): ['00000100101010000000'],
("XOR","(Dir)"): ['00000000001010010100'],
("XOR","A","(B)"): ['00001000101010100000'],
("XOR","B","(B)"): ['00000100101010100000'],
("NOT","A"): ['00001000001000000000'],
("NOT","B","A"): ['00000100001000000000'],
("NOT","(Dir)","A"): ['00000000001000010100'],
("NOT","(B)","A"): ['00000000001000110100'],
("SHL","A"): ['00001000001100000000'],
("SHL","B","A"): ['00000100001100000000'],
("SHL","(Dir)","A"): ['00000000001100010100'],
("SHL","(B)","A"): ['00000000001100110100'],
("SHR","A"): ['00001000001110000000'],
("SHR","B","A"): ['00000100001110000000'],
("SHR","(Dir)","A"): ['00000000001110010100'],
("SHR","(B)","A"): ['00000000001110110100'],
("INC","A"): ['00001000010000000000'],
("INC","B"): ['00000101000000000000'],
("INC","(Dir)"): ['00000001100000010100'],
("INC","(B)"): ['00000001100000110100'],
("DEC","A"): ['00001000010010000000'],
("CMP","A","B"): ['00000000000010000000'],
("CMP","A","Lit"): ['00000000010010000000'],
("CMP","A","(Dir)"): ['00000000100010010000'],
("CMP","A","(B)"): ['00000000100010110000'],
("JMP","INS"): ['00010000000000001000'],
("JEQ","INS"): ['00110000000000001000'],
("JNE","INS"): ['01010000000000001000'],
("JGT","INS"): ['01110000000000001000'],
("JLT","INS"): ['10010000000000001000'],
("JGE","INS"): ['10110000000000001000'],
("JLE","INS"): ['11010000000000001000'],
("JCR","INS"): ['11110000000000001000'],
("CALL","INS"): ['00010000000001001101'],
("RET"): ['00000000000000000010','00010000000001000000'],
("PUSH","A"): ['00000000110001010101'],
("PUSH","B"): ['00000011000001010101'],
("POP","A"): ['00000000000000000010','00001011100001010000'],
("POP","B"): ['00000000000000000010','00000111100001010000'],
("NOP"): ['00000000000000000000']
}

if(__name__ == "__main__"):
    print(romBase)
    print(romEnd)



