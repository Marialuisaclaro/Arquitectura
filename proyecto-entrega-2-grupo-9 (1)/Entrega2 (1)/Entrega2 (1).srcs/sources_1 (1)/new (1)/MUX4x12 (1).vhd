library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX4x12 is
  Port ( A0, A1, A2, A3: in STD_LOGIC_VECTOR (11 downto 0);
         B0, B1 : in STD_LOGIC;
         S0 : out STD_LOGIC_VECTOR (11 downto 0));
end MUX4x12;

architecture structural of MUX4x12 is
    component MUX2
        Port ( A0, A1, B0 : in STD_LOGIC; S0 : out STD_LOGIC);
    end component;
    signal W0, W1: STD_LOGIC_VECTOR (0 to 11);
begin
    M0_0: MUX2 port map (A0(0), A1(0), B0, W0(0));
    M0_1: MUX2 port map (A2(0), A3(0), B0, W1(0));
    M0_2: MUX2 port map (W0(0), W1(0), B1, S0(0));
    M1_0: MUX2 port map (A0(1), A1(1), B0, W0(1));
    M1_1: MUX2 port map (A2(1), A3(1), B0, W1(1));
    M1_2: MUX2 port map (W0(1), W1(1), B1, S0(1));
    M2_0: MUX2 port map (A0(2), A1(2), B0, W0(2));
    M2_1: MUX2 port map (A2(2), A3(2), B0, W1(2));
    M2_2: MUX2 port map (W0(2), W1(2), B1, S0(2));
    M3_0: MUX2 port map (A0(3), A1(3), B0, W0(3));
    M3_1: MUX2 port map (A2(3), A3(3), B0, W1(3));
    M3_2: MUX2 port map (W0(3), W1(3), B1, S0(3));
    M4_0: MUX2 port map (A0(4), A1(4), B0, W0(4));
    M4_1: MUX2 port map (A2(4), A3(4), B0, W1(4));
    M4_2: MUX2 port map (W0(4), W1(4), B1, S0(4));
    M5_0: MUX2 port map (A0(5), A1(5), B0, W0(5));
    M5_1: MUX2 port map (A2(5), A3(5), B0, W1(5));
    M5_2: MUX2 port map (W0(5), W1(5), B1, S0(5));
    M6_0: MUX2 port map (A0(6), A1(6), B0, W0(6));
    M6_1: MUX2 port map (A2(6), A3(6), B0, W1(6));
    M6_2: MUX2 port map (W0(6), W1(6), B1, S0(6));
    M7_0: MUX2 port map (A0(7), A1(7), B0, W0(7));
    M7_1: MUX2 port map (A2(7), A3(7), B0, W1(7));
    M7_2: MUX2 port map (W0(7), W1(7), B1, S0(7));
    M8_0: MUX2 port map (A0(8), A1(8), B0, W0(8));
    M8_1: MUX2 port map (A2(8), A3(8), B0, W1(8));
    M8_2: MUX2 port map (W0(8), W1(8), B1, S0(8));
    M9_0: MUX2 port map (A0(9), A1(9), B0, W0(9));
    M9_1: MUX2 port map (A2(9), A3(9), B0, W1(9));
    M9_2: MUX2 port map (W0(9), W1(9), B1, S0(9));
    M10_0: MUX2 port map (A0(10), A1(10), B0, W0(10));
    M10_1: MUX2 port map (A2(10), A3(10), B0, W1(10));
    M10_2: MUX2 port map (W0(10), W1(10), B1, S0(10));
    M11_0: MUX2 port map (A0(11), A1(11), B0, W0(11));
    M11_1: MUX2 port map (A2(11), A3(11), B0, W1(11));
    M11_2: MUX2 port map (W0(11), W1(11), B1, S0(11));

end structural;