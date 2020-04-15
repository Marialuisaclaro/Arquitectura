library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2 is
  Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
end MUX2;

architecture structural of MUX2 is
begin
    S0 <= (A0 and not B0) or (A1 and B0);
end structural;
