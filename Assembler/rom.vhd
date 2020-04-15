library IEEE;
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

"000010110100000000000000000000001001", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000000", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000011", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000001", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000000", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000010", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000000", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000011", --('MOV', '(Dir)', 'A')
"000010110100000000000000000011111111", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000100", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000000", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000101", --('MOV', '(Dir)', 'A')
"000010110100000000000101010101010101", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000110", --('MOV', '(Dir)', 'A')
"000010110100000000001010101010101010", --('MOV', 'A', 'Lit')
"000000001100000101000000000000000111", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000000", --('MOV', 'A', 'Lit')
"000000001100000101000000000000001000", --('MOV', '(Dir)', 'A')
"000010110100000000000000000000000000", --('MOV', 'A', 'Lit')
"000000001100000101000000000000001001", --('MOV', '(Dir)', 'A')
"000010111000000000000000000000000000", --('MOV', 'A', '(Dir)')
