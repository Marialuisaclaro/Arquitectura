library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX8x16 is
  Port ( A0, A1, A2, A3, A4, A5, A6, A7 : in STD_LOGIC_VECTOR (15 downto 0);
         B0, B1, B2 : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR (15 downto 0));
end MUX8x16;

architecture structural of MUX8x16 is
component MUX8 is
  Port ( A0, A1, A2, A3, A4, A5, A6, A7: in STD_LOGIC;
         B0, B1, B2 : in STD_LOGIC;
         S0 : out STD_LOGIC);
end component;

begin
    M0: MUX8 port map (A0(0), A1(0), A2(0), A3(0), A4(0), A5(0), A6(0), A7(0), B0, B1, B2, S(0));
    M1: MUX8 port map (A0(1), A1(1), A2(1), A3(1), A4(1), A5(1), A6(1), A7(1), B0, B1, B2, S(1));
    M2: MUX8 port map (A0(2), A1(2), A2(2), A3(2), A4(2), A5(2), A6(2), A7(2), B0, B1, B2, S(2));
    M3: MUX8 port map (A0(3), A1(3), A2(3), A3(3), A4(3), A5(3), A6(3), A7(3), B0, B1, B2, S(3));
    M4: MUX8 port map (A0(4), A1(4), A2(4), A3(4), A4(4), A5(4), A6(4), A7(4), B0, B1, B2, S(4));
    M5: MUX8 port map (A0(5), A1(5), A2(5), A3(5), A4(5), A5(5), A6(5), A7(5), B0, B1, B2, S(5));
    M6: MUX8 port map (A0(6), A1(6), A2(6), A3(6), A4(6), A5(6), A6(6), A7(6), B0, B1, B2, S(6));
    M7: MUX8 port map (A0(7), A1(7), A2(7), A3(7), A4(7), A5(7), A6(7), A7(7), B0, B1, B2, S(7));
    M8: MUX8 port map (A0(8), A1(8), A2(8), A3(8), A4(8), A5(8), A6(8), A7(8), B0, B1, B2, S(8));
    M9: MUX8 port map (A0(9), A1(9), A2(9), A3(9), A4(9), A5(9), A6(9), A7(9), B0, B1, B2, S(9));
    M10: MUX8 port map (A0(10), A1(10), A2(10), A3(10), A4(10), A5(10), A6(10), A7(10), B0, B1, B2, S(10));
    M11: MUX8 port map (A0(11), A1(11), A2(11), A3(11), A4(11), A5(11), A6(11), A7(11), B0, B1, B2, S(11));
    M12: MUX8 port map (A0(12), A1(12), A2(12), A3(12), A4(12), A5(12), A6(12), A7(12), B0, B1, B2, S(12));
    M13: MUX8 port map (A0(13), A1(13), A2(13), A3(13), A4(13), A5(13), A6(13), A7(13), B0, B1, B2, S(13));
    M14: MUX8 port map (A0(14), A1(14), A2(14), A3(14), A4(14), A5(14), A6(14), A7(14), B0, B1, B2, S(14));
    M15: MUX8 port map (A0(15), A1(15), A2(15), A3(15), A4(15), A5(15), A6(15), A7(15), B0, B1, B2, S(15));


end structural;