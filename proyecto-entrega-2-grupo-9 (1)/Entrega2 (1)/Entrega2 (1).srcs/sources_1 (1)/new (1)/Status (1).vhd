library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity Status is
    Port ( clock    : in  std_logic;
           datain   : in  std_logic_vector (2 downto 0);
           dataout  : out std_logic_vector (2 downto 0));
end Status;

architecture Behavioral of Status is

signal reg : std_logic_vector(2 downto 0) := (others => '0'); -- Señales del registro. Parten en 0.

begin

reg_prosses : process (clock)           -- Proceso sensible a clock.
        begin
          if (rising_edge(clock)) then  -- Condición de flanco de subida de clock.
              reg <= datain;            -- Si load = 1, carga la entrada de datos en el registro.
          end if;
        end process;
        
dataout <= reg;                         -- Los datos del registro salen sin importar el estado de clock.
            
end Behavioral;