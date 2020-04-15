library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX2x16 is
  Port ( A0, A1: in STD_LOGIC_VECTOR (15 downto 0);
         B : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR (15 downto 0));
end MUX2x16;

architecture structural of MUX2x16 is
    component MUX2
        Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
begin
    M0: MUX2 port map (A0(0), A1(0), B, S(0));

    M1: MUX2 port map (A0(1), A1(1), B, S(1));
    M2: MUX2 port map (A0(2), A1(2), B, S(2));
    M3: MUX2 port map (A0(3), A1(3), B, S(3));
    M4: MUX2 port map (A0(4), A1(4), B, S(4));
    M5: MUX2 port map (A0(5), A1(5), B, S(5));
    M6: MUX2 port map (A0(6), A1(6), B, S(6));
    M7: MUX2 port map (A0(7), A1(7), B, S(7));
    M8: MUX2 port map (A0(8), A1(8), B, S(8));

    M9: MUX2 port map (A0(9), A1(9), B, S(9));
    M10: MUX2 port map (A0(10), A1(10), B, S(10));
    M11: MUX2 port map (A0(11), A1(11), B, S(11));
    M12: MUX2 port map (A0(12), A1(12), B, S(12));
    M13: MUX2 port map (A0(13), A1(13), B, S(13));
    M14: MUX2 port map (A0(14), A1(14), B, S(14));
    M15: MUX2 port map (A0(15), A1(15), B, S(15));

end structural;
