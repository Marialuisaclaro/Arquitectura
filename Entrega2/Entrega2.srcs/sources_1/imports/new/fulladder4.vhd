----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/06/2019 01:17:12 AM
-- Design Name: 
-- Module Name: fulladder4 - Behavioral
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

entity fulladder4 is
    Port ( Cin4 : in STD_LOGIC;
           A0 : in STD_LOGIC;
           A1 : in STD_LOGIC;
           A2 : in STD_LOGIC;
           A3 : in STD_LOGIC;
           B0 : in STD_LOGIC;
           B1 : in STD_LOGIC;
           B2 : in STD_LOGIC;
           B3 : in STD_LOGIC;
           S0 : inout STD_LOGIC;
           S1 : inout STD_LOGIC;
           S2 : inout STD_LOGIC;
           S3 : inout STD_LOGIC;
           Cout4 : inout STD_LOGIC;
           clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0)
           );
end fulladder4;

architecture Behavioral of fulladder4 is

component fulladd
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           sum : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

component Decimal_BCD is
    Port ( n : in STD_LOGIC_VECTOR (4 downto 0);
    dec : out STD_LOGIC_VECTOR (3 downto 0);
    unit : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

component Display_Controller is
    Port (
        dis_a       : in   STD_LOGIC_VECTOR (3 downto 0);
        dis_b       : in   STD_LOGIC_VECTOR (3 downto 0);
        dis_c       : in   STD_LOGIC_VECTOR (3 downto 0);
        dis_d       : in   STD_LOGIC_VECTOR (3 downto 0);
        clk         : in   STD_LOGIC;
        seg         : out  STD_LOGIC_VECTOR (7 downto 0);
        an          : out  STD_LOGIC_VECTOR (3 downto 0)
          );
end component;

signal C0,C1,C2 : std_logic;
signal n : STD_LOGIC_VECTOR(4 downto 0);
signal dec : STD_LOGIC_VECTOR(3 downto 0);
signal uni : STD_LOGIC_VECTOR(3 downto 0);
signal zero : STD_LOGIC_VECTOR(3 downto 0);

begin

FA1: fulladd port map (A0,B0,Cin4,S0,C0);
FA2: fulladd port map (A1,B1,C0,S1,C1);
FA3: fulladd port map( A2,B2,C1,S2,C2);
FA4: fulladd port map (A3,B3,C2,S3,Cout4);

n(0) <= S0;
n(1) <= S1;
n(2) <= S2;
n(3) <= S3;
n(4) <= Cout4;

zero(0) <= '0';
zero(1) <= '0';
zero(2) <= '0';
zero(3) <= '0';

Bin_bcd: Decimal_BCD port map (n, dec, uni);
Displ : Display_Controller port map (zero, zero, dec, uni, clk, seg, an);

end Behavioral;
