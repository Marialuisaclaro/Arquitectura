library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity program_counter is
  Port ( clock     : in std_logic; -- Clock rising edge
         load      : in std_logic; -- 1 if loading outside data, 0 else
         data_in   : in std_logic_vector (11 downto 0); -- Input when loading data
         data_out  : out std_logic_vector (11 downto 0)); -- Output
end program_counter;

architecture Behavioral of program_counter is

signal instruction_number : std_logic_vector (11 downto 0) := "000000000000"; -- Starting Value 0

begin

state_change: process(clock)
begin
    if (rising_edge(clock)) then
        if (load='1') then
            instruction_number <= data_in;
        else
            instruction_number <= instruction_number + 1;
        end if;
    end if;
end process;

data_out <= instruction_number;

end Behavioral;
