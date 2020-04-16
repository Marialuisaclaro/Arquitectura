library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Principal is
    Port ( clk : in STD_LOGIC;
           seg : out STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0));
end Principal;

architecture Behavioral of Principal is

component RAM is
    Port (
        clock       : in   std_logic;
        write       : in   std_logic;
        address     : in   std_logic_vector (11 downto 0);
        datain      : in   std_logic_vector (15 downto 0);
        dataout     : out  std_logic_vector (15 downto 0)
          );
end component;

component ROM is
    Port (
        address   : in  std_logic_vector(11 downto 0);
        dataout   : out std_logic_vector(35 downto 0)
          );
end component;

component Reg is
    Port ( clock    : in  std_logic;                        -- Señal del clock (reducido).
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (15 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (15 downto 0));  -- Señales de salida de datos.
end component; 

component MUX4x16 is
  Port ( A0, A1, A2, A3: in STD_LOGIC_VECTOR (15 downto 0);
         B0, B1 : in STD_LOGIC;
         S0 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX4x12 is
  Port ( A0, A1, A2, A3: in STD_LOGIC_VECTOR (11 downto 0);
         B0, B1 : in STD_LOGIC;
         S0 : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component MUX2x16 is
  Port ( A0, A1: in STD_LOGIC_VECTOR (15 downto 0);
         B : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component MUX2x12 is
  Port ( A0, A1: in STD_LOGIC_VECTOR (11 downto 0);
         B : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component Display_Controller is
    Port (
        dis_a       : in   std_logic_vector (3 downto 0);
        dis_b       : in   std_logic_vector (3 downto 0);
        dis_c       : in   std_logic_vector (3 downto 0);
        dis_d       : in   std_logic_vector (3 downto 0);
        clk         : in   std_logic;
        seg         : out  std_logic_vector (7 downto 0);
        an          : out  std_logic_vector (3 downto 0)
          );
end component;

component Clock_Divider is
    Port ( clk         : in std_logic;
           speed       : in std_logic_vector (1 downto 0);
           clock       : out std_logic);
end component;

component ALU is
    Port ( clock: in STD_LOGIC;
           input1, input2 : in STD_LOGIC_VECTOR (15 downto 0);
           selector : in STD_LOGIC_VECTOR (2 downto 0);
           output : out STD_LOGIC_VECTOR (15 downto 0);
           status : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component adder12 is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           S : out STD_LOGIC_VECTOR (11 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC);
end component;

component program_counter is
    Port ( clock     : in std_logic; -- Clock rising edge
        load      : in std_logic; -- 1 if loading outside data, 0 else
        data_in   : in std_logic_vector (11 downto 0); -- Input when loading data
        data_out  : out std_logic_vector (11 downto 0)); -- Output
end component;

component Status is
    Port ( clock    : in  std_logic;
           datain   : in  std_logic_vector (2 downto 0);
           dataout  : out std_logic_vector (2 downto 0));
end component;

component SP is
    Port ( clock    : in  std_logic;                        -- Señal del clock (reducido).
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (11 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (11 downto 0));  -- Señales de salida de datos.
end component;

component Control_unit is
    Port (  ins: in std_logic_vector (19 downto 0);
            status: in std_logic_vector (2 downto 0);
            ram_w, load_pc, load_reg_a, load_reg_b: out std_logic;
            sel_mux_a, sel_mux_b: out std_logic_vector (0 to 1);
            sel_alu: out std_logic_vector (0 to 2); -- s_add nueva signal
            s_add: out std_logic_vector (0 to 1);
            sd_in, spc, inc_sp, dec_sp: out std_logic -- sd_in, spc, inc_sp and dec_sp nueva singal
        );
end component;

signal clock: std_logic;
signal clock_speed: std_logic_vector (1 downto 0):= (others => '0');
signal ram_w, load_pc, load_reg_a, load_reg_b: std_logic:= '0';
signal inc_sp, dec_sp: std_logic:= '0';
signal in_pc, out_pc, out_sp, out_add: std_logic_vector (11 downto 0);
signal sel_mux_a, sel_mux_b, sel_mux_s: std_logic_vector (1 downto 0):= (others => '0');
signal sel_mux_pc, sel_d_in: std_logic:= '0';
signal ram_dir, lit12: std_logic_vector (11 downto 0);
signal instruccion: std_logic_vector (35 downto 0):= (others => '0');
signal sel_alu: std_logic_vector (2 downto 0):= (others => '0');
signal new_stats, stats: std_logic_vector (2 downto 0):= (others => '0');
signal ram_data_in, ram_data_out, lit16, out_add_16: std_logic_vector (15 downto 0):= (others => '0');
signal resultado, reg_a_out, reg_b_out, mux_a_out, mux_b_out: std_logic_vector (15 downto 0):= (others => '0');

signal AddCin, AddCout: std_logic:= '0';
-- A definir 
-- A�adir a control unit "inc_sp", "dec_sp", "sel_mux_s(0:1)", "sel_mux_pc", "sel_d_in"

begin
    clock_speed <= "10";
    lit16 <= instruccion(15 downto 0);
    lit12 <= instruccion(11 downto 0);
    out_add_16 <= ("0000" & out_add);
    DivisorDeClock: Clock_Divider port map (clk, clock_speed, clock);
    PC: program_counter port map (clock, load_pc, in_pc, out_pc);
    MUXPC: MUX2x12 port map (ram_data_out(11 downto 0), lit12, sel_mux_pc, in_pc);
    StackPointer: SP port map (clock, '0', inc_sp, dec_sp,"000000000000", out_sp);
    MUXS: MUX4x12 port map (lit12, reg_b_out(11 downto 0), out_sp, "000000000000", sel_mux_s(0), sel_mux_s(1), ram_dir);
    Adder: adder12 port map ("000000000001", out_pc, out_add, AddCin, AddCout);
    MUXDataIN: MUX2x16 port map (out_add_16, resultado, sel_d_in, ram_data_in);
    MemoriaRAM: RAM port map (clock, ram_w, ram_dir, ram_data_in, ram_data_out);
    MemoriaROM: ROM port map (out_pc, instruccion);
    RegistroA: Reg port map (clock, load_reg_a, '0', '0', resultado, reg_a_out);
    RegistroB: Reg port map (clock, load_reg_b, '0', '0', resultado, reg_b_out);
    MUXA: MUX4x16 port map (reg_a_out, "0000000000000001", "0000000000000000", "0000000000000000", sel_mux_a(0), sel_mux_a(1), mux_a_out);
    MUXB: MUX4x16 port map (reg_b_out, lit16, ram_data_out, "0000000000000000", sel_mux_b(0), sel_mux_b(1), mux_b_out);
    UnidadLogicaAritmetica: ALU port map (clock, mux_a_out, mux_b_out, sel_alu, resultado, new_stats);
    Estatus: Status port map (clock, new_stats, stats);
    CU: Control_unit port map (instruccion(35 downto 16), stats, ram_w, load_pc, load_reg_a, load_reg_b, sel_mux_a, sel_mux_b, sel_alu, sel_mux_s, sel_d_in, sel_mux_pc, inc_sp, dec_sp);
    Displayer: Display_Controller port map (reg_a_out(7 downto 4), reg_a_out(3 downto 0), reg_b_out(7 downto 4), reg_b_out(3 downto 0), clk, seg, an);
    
    


    led(0) <= load_pc;
    led(1) <= load_reg_a;
    led(2) <= load_reg_b;
    led(3) <= sel_mux_a(0);
    led(4) <= sel_mux_a(1);
    led(5) <= sel_mux_b(0);
    led(6) <= sel_mux_b(1);
    led(7) <= sel_alu(0);
    led(8) <= sel_alu(1);
    led(9) <= sel_alu(2);
    led(10) <= ram_w;
    led(11) <= '0';
    led(12) <= '0';
    led(13) <= '0';
    led(14) <= '0';
    with out_pc select
        led(15) <=
            '1' when "000000001001",
            '0' when others;

end Behavioral;

