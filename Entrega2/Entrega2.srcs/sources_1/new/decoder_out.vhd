library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity decoder_out is
    Port ( selector : in std_logic_vector (15 downto 0);
           load_out : in  std_logic;
           load_dis : out  std_logic;
           load_led : out  std_logic);
end decoder_out;

architecture Behavioral of decoder_out is

begin
    load_dis <= not selector(0) and load_out;
    load_led <= selector(0) and load_out;
    
end Behavioral;