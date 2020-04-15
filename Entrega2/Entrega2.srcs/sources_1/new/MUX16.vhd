library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX16 is
  Port ( A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15 : in STD_LOGIC;
         B0, B1, B2, B3 : in STD_LOGIC;
         S0 : out STD_LOGIC);
end MUX16;

architecture structural of MUX16 is
    component MUX8
        Port ( A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    component MUX2
        Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    signal W0, W1: STD_LOGIC;
begin
    M0: MUX8 port map (A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, W0);
    M1: MUX8 port map (A8, A9, A10, A11, A12, A13, A14, A15, B0, B1, B2, W1);
    M2: MUX2 port map (W0, W1, B3, S0);
end structural;