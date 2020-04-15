----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/08/2019 07:22:46 PM
-- Design Name: 
-- Module Name: adder16 - Behavioral
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

entity adder16 is
    Port ( Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           A : in STD_LOGIC_VECTOR (15 downto 0);
           B : in STD_LOGIC_VECTOR (15 downto 0);
           S : out STD_LOGIC_VECTOR (15 downto 0));
end adder16;

architecture Behavioral of adder16 is

component fulladd
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;


signal Carry : STD_LOGIC_VECTOR (14 downto 0);

begin

ADDER_0: fulladd port map (A(0),B(0),Cin,S(0),Carry(0));
ADDER_1: fulladd port map (A(1),B(1),Carry(0),S(1),Carry(1));
ADDER_2: fulladd port map (A(2),B(2),Carry(1),S(2),Carry(2));
ADDER_3: fulladd port map (A(3),B(3),Carry(2),S(3),Carry(3));
ADDER_4: fulladd port map (A(4),B(4),Carry(3),S(4),Carry(4));
ADDER_5: fulladd port map (A(5),B(5),Carry(4),S(5),Carry(5));
ADDER_6: fulladd port map (A(6),B(6),Carry(5),S(6),Carry(6));
ADDER_7: fulladd port map (A(7),B(7),Carry(6),S(7),Carry(7));
ADDER_8: fulladd port map (A(8),B(8),Carry(7),S(8),Carry(8));
ADDER_9: fulladd port map (A(9),B(9),Carry(8),S(9),Carry(9));
ADDER_10: fulladd port map (A(10),B(10),Carry(9),S(10),Carry(10));
ADDER_11: fulladd port map (A(11),B(11),Carry(10),S(11),Carry(11));
ADDER_12: fulladd port map (A(12),B(12),Carry(11),S(12),Carry(12));
ADDER_13: fulladd port map (A(13),B(13),Carry(12),S(13),Carry(13));
ADDER_14: fulladd port map (A(14),B(14),Carry(13),S(14),Carry(14));
ADDER_15: fulladd port map (A(15),B(15),Carry(14),S(15),Cout);

end Behavioral;
