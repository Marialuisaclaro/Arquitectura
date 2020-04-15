library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;


entity ALU is
    Port ( clock: in STD_LOGIC;
           input1, input2 : in STD_LOGIC_VECTOR (15 downto 0);
           selector : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0);
           status : out STD_LOGIC_VECTOR (2 downto 0));
end ALU;

architecture Behavioral of ALU is
-- Importamos nuestro MUX8 hecho previamente en otro modulo
    component MUX8
        Port ( A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2: in STD_LOGIC; S0: out STD_LOGIC);
    end component;
-- Importamos adder16 y sub16
    component adder16
        Port ( Cin: in STD_LOGIC; 
                Cout: out STD_LOGIC; 
                A, B: in STD_LOGIC_VECTOR(15 downto 0); 
                S: out STD_LOGIC_VECTOR(15 downto 0));
    end component;
    component sub16
        Port ( Cin: in STD_LOGIC; 
        Cout: out STD_LOGIC; 
        A, B: in STD_LOGIC_VECTOR(15 downto 0); 
        S: out STD_LOGIC_VECTOR(15 downto 0));
    end component;

-- Y creamos nuestros cables que seran las entras al MUX8,
-- o sea que tendran los resultados de cada operacion l�gica
    signal W0, W1, W2, W3, W4, W5, W6, W7, salida: STD_LOGIC_VECTOR(15 downto 0);
    
-- Variable Auxiliar para comparacion mayor/menor
    signal number_a, number_b: unsigned(15 downto 0);
    signal carry1,carry2: STD_LOGIC;
    
begin
-- ADD)
    ADDER: adder16 port map ('0', carry1, input1, input2, W0);

-- SUB
    SUBER: sub16 port map ('0', carry2, input1, input2, W1);


-- AND
    W2(0) <= input1(0) and input2(0);
    W2(1) <= input1(1) and input2(1);
    W2(2) <= input1(2) and input2(2);
    W2(3) <= input1(3) and input2(3);
    W2(4) <= input1(4) and input2(4);
    W2(5) <= input1(5) and input2(5);
    W2(6) <= input1(6) and input2(6);
    W2(7) <= input1(7) and input2(7);
    W2(8) <= input1(8) and input2(8);
    W2(9) <= input1(9) and input2(9);
    W2(10) <= input1(10) and input2(10);
    W2(11) <= input1(11) and input2(11);
    W2(12) <= input1(12) and input2(12);
    W2(13) <= input1(13) and input2(13);
    W2(14) <= input1(14) and input2(14);
    W2(15) <= input1(15) and input2(15);

-- OR
    W3(0) <= input1(0) or input2(0);
    W3(1) <= input1(1) or input2(1);
    W3(2) <= input1(2) or input2(2);
    W3(3) <= input1(3) or input2(3);
    W3(4) <= input1(4) or input2(4);
    W3(5) <= input1(5) or input2(5);
    W3(6) <= input1(6) or input2(6);
    W3(7) <= input1(7) or input2(7);
    W3(8) <= input1(8) or input2(8);
    W3(9) <= input1(9) or input2(9);
    W3(10) <= input1(10) or input2(10);
    W3(11) <= input1(11) or input2(11);
    W3(12) <= input1(12) or input2(12);
    W3(13) <= input1(13) or input2(13);
    W3(14) <= input1(14) or input2(14);
    W3(15) <= input1(15) or input2(15);
    
-- NOT
    W4(0) <= not input1(0);
    W4(1) <= not input1(1);
    W4(2) <= not input1(2);
    W4(3) <= not input1(3);
    W4(4) <= not input1(4);
    W4(5) <= not input1(5);
    W4(6) <= not input1(6);
    W4(7) <= not input1(7);
    W4(8) <= not input1(8);
    W4(9) <= not input1(9);
    W4(10) <= not input1(10);
    W4(11) <= not input1(11);
    W4(12) <= not input1(12);
    W4(13) <= not input1(13);
    W4(14) <= not input1(14);
    W4(15) <= not input1(15);

-- XOR
    W5(0) <= (input1(0) or input2(0)) and not (input1(0) and input2(0));
    W5(1) <= (input1(1) or input2(1)) and not (input1(1) and input2(1));
    W5(2) <= (input1(2) or input2(2)) and not (input1(2) and input2(2));
    W5(3) <= (input1(3) or input2(3)) and not (input1(3) and input2(3));
    W5(4) <= (input1(4) or input2(4)) and not (input1(4) and input2(4));
    W5(5) <= (input1(5) or input2(5)) and not (input1(5) and input2(5));
    W5(6) <= (input1(6) or input2(6)) and not (input1(6) and input2(6));
    W5(7) <= (input1(7) or input2(7)) and not (input1(7) and input2(7));
    W5(8) <= (input1(8) or input2(8)) and not (input1(8) and input2(8));
    W5(9) <= (input1(9) or input2(9)) and not (input1(9) and input2(9));
    W5(10) <= (input1(10) or input2(10)) and not (input1(10) and input2(10));
    W5(11) <= (input1(11) or input2(11)) and not (input1(11) and input2(11));
    W5(12) <= (input1(12) or input2(12)) and not (input1(12) and input2(12));
    W5(13) <= (input1(13) or input2(13)) and not (input1(13) and input2(13));
    W5(14) <= (input1(14) or input2(14)) and not (input1(14) and input2(14));
    W5(15) <= (input1(15) or input2(15)) and not (input1(15) and input2(15));

-- SHL
    W6 <=  input1(14 downto 0)&'0';
    -- status(0) <= input1(15);

-- SHR
    W7 <=  '0'&input1(15 downto 1);
    -- status(0) <= input1(0);

-- Ya definidas las salidas hacemos los MUX8 y outputeamos
    L0: MUX8 port map (W0(0), W1(0), W2(0), W3(0), W4(0), W5(0), W6(0), W7(0), selector(0), selector(1), selector(2), salida(0));
    L1: MUX8 port map (W0(1), W1(1), W2(1), W3(1), W4(1), W5(1), W6(1), W7(1), selector(0), selector(1), selector(2), salida(1));
    L2: MUX8 port map (W0(2), W1(2), W2(2), W3(2), W4(2), W5(2), W6(2), W7(2), selector(0), selector(1), selector(2), salida(2));
    L3: MUX8 port map (W0(3), W1(3), W2(3), W3(3), W4(3), W5(3), W6(3), W7(3), selector(0), selector(1), selector(2), salida(3));
    L4: MUX8 port map (W0(4), W1(4), W2(4), W3(4), W4(4), W5(4), W6(4), W7(4), selector(0), selector(1), selector(2), salida(4));
    L5: MUX8 port map (W0(5), W1(5), W2(5), W3(5), W4(5), W5(5), W6(5), W7(5), selector(0), selector(1), selector(2), salida(5));
    L6: MUX8 port map (W0(6), W1(6), W2(6), W3(6), W4(6), W5(6), W6(6), W7(6), selector(0), selector(1), selector(2), salida(6));
    L7: MUX8 port map (W0(7), W1(7), W2(7), W3(7), W4(7), W5(7), W6(7), W7(7), selector(0), selector(1), selector(2), salida(7));
    L8: MUX8 port map (W0(8), W1(8), W2(8), W3(8), W4(8), W5(8), W6(8), W7(8), selector(0), selector(1), selector(2), salida(8));
    L9: MUX8 port map (W0(9), W1(9), W2(9), W3(9), W4(9), W5(9), W6(9), W7(9), selector(0), selector(1), selector(2), salida(9));
    L10: MUX8 port map (W0(10), W1(10), W2(10), W3(10), W4(10), W5(10), W6(10), W7(10), selector(0), selector(1), selector(2), salida(10));
    L11: MUX8 port map (W0(11), W1(11), W2(11), W3(11), W4(11), W5(11), W6(11), W7(11), selector(0), selector(1), selector(2), salida(11));
    L12: MUX8 port map (W0(12), W1(12), W2(12), W3(12), W4(12), W5(12), W6(12), W7(12), selector(0), selector(1), selector(2), salida(12));
    L13: MUX8 port map (W0(13), W1(13), W2(13), W3(13), W4(13), W5(13), W6(13), W7(13), selector(0), selector(1), selector(2), salida(13));
    L14: MUX8 port map (W0(14), W1(14), W2(14), W3(14), W4(14), W5(14), W6(14), W7(14), selector(0), selector(1), selector(2), salida(14));
    L15: MUX8 port map (W0(15), W1(15), W2(15), W3(15), W4(15), W5(15), W6(15), W7(15), selector(0), selector(1), selector(2), salida(15));

output <= salida;

--when salida select
--    status(1) <=
--        '1' when "0000000000000000",
--        '0' when others;

check_zero: process (clock)
    begin
        if (salida = "0000000000000000") then
            status(1) <= '1';
        else
            status(1) <= '0';
        end if;
    end process;
    
check_n: process (clock)
    begin
        if ((unsigned(input1) < unsigned(input2)) and selector = "001") then
            status(0) <= '1';
        else
            status(0) <= '0';
        end if;
    end process;

check_c: process (clock)
    begin
        if selector = "000" then --add
            status(2) <= carry1;
        elsif selector = "001" then --sub
            status(2) <= carry2;
        elsif selector = "111" then --shr
            status(2) <= input1(0);
        elsif selector = "110" then --shl
            status(2) <= input1(15);
        else
            status(2) <= '0';
        end if;
    end process;
        
end Behavioral;


