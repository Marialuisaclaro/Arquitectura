----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2019 08:05:23 PM
-- Design Name: 
-- Module Name: sub16 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sub16 is
    Port ( Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0));
end sub16;

architecture Behavioral of sub16 is

component adder16
    Port ( Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal Bnegado : STD_LOGIC_VECTOR (15 downto 0);
signal Bnegative : STD_LOGIC_VECTOR (15 downto 0);
signal one : STD_LOGIC_VECTOR (15 downto 0);
signal C : STD_LOGIC;

begin

one(0) <= '1';
one(1) <= '0';
one(2) <= '0';
one(3) <= '0';
one(4) <= '0';
one(5) <= '0';
one(6) <= '0';
one(7) <= '0';
one(8) <= '0';
one(9) <= '0';
one(10) <= '0';
one(11) <= '0';
one(12) <= '0';
one(13) <= '0';
one(14) <= '0';
one(15) <= '0';

Bnegado <= not B;
ADD_ONE: adder16 port map ('0', C, Bnegado, one, Bnegative);

SUB: adder16 port map (Cin,Cout,A,Bnegative,S);

end Behavioral;
