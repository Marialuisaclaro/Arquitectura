library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
    Port (  ins: in std_logic_vector (19 downto 0);
            status: in std_logic_vector (2 downto 0);
            ram_w, load_pc, load_reg_a, load_reg_b: out std_logic;
            sel_mux_a, sel_mux_b: out std_logic_vector (0 to 1);
            sel_alu: out std_logic_vector (0 to 2); -- s_add nueva signal
            s_add: out std_logic_vector (0 to 1);
            sd_in, spc, inc_sp, dec_sp: out std_logic -- sd_in, spc, inc_sp and dec_sp nueva singal
        );
end Control_unit;

architecture Behavioral of Control_unit is

signal load_pc_aux, load_pc_eq, load_pc_ne: std_logic;
signal saltos: std_logic_vector(2 downto 0);

begin

saltos <= ins(19 downto 17);

load_pc_aux <= ins(16);

with saltos select
    load_pc <=
        load_pc_aux when "000",
        (load_pc_aux and status(1)) when "001",
        (load_pc_aux and not status(1)) when "010",
        (load_pc_aux and not status(0) and not status(1)) when "011",
        (load_pc_aux and status(0)) when "100",
        (load_pc_aux and not status(0)) when "101",
        ((load_pc_aux and status(0)) or (load_pc_aux and status(1))) when "110",
        (load_pc_aux and status(2)) when "111",
        '0' when others;

load_reg_a <= ins(15);

load_reg_b <= ins(14);

sel_mux_a(0) <= ins(13);

sel_mux_a(1) <= ins(12);

sel_mux_b(0) <= ins(11);

sel_mux_b(1) <= ins(10);

sel_alu(0) <= ins(9);

sel_alu(1) <= ins(8);

sel_alu(2) <= ins(7);

s_add(0) <= ins(6);

s_add(1) <= ins(5);

sd_in <= ins(4);

spc <= ins(3);

ram_w <= ins(2);

inc_sp <= ins(1);

dec_sp <= ins(0);

end Behavioral;

