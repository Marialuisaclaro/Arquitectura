library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8 is
  Port ( A0, A1, A2, A3, A4, A5, A6, A7 : in STD_LOGIC;
         B0, B1, B2 : in STD_LOGIC;
         S0 : out STD_LOGIC);
end MUX8;

architecture structural of MUX8 is
    component MUX4
        Port ( A0, A1, A2, A3, B0, B1 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    component MUX2
        Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    signal W0, W1: STD_LOGIC;
begin
    M0: MUX4 port map (A0, A1, A2, A3, B0, B1, W0);
    M1: MUX4 port map (A4, A5, A6, A7, B0, B1, W1);
    M2: MUX2 port map (W0, W1, B2, S0);
end structural;