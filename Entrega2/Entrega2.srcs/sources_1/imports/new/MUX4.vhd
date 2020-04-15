library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4 is
  Port ( A0, A1, A2, A3, B0, B1 : in STD_LOGIC; S0 : out STD_LOGIC);
end MUX4;

architecture structural of MUX4 is
    component MUX2
        Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    signal W0, W1: STD_LOGIC;
begin
    M0: MUX2 port map (A0, A1, B0, W0);
    M1: MUX2 port map (A2, A3, B0, W1);
    M2: MUX2 port map (W0, W1, B1, S0);
end structural;