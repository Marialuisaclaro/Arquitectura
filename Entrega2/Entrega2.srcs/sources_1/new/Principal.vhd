library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Principal is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           btnC : in STD_LOGIC;
           btnU : in STD_LOGIC;
           btnL : in STD_LOGIC;
           btnR : in STD_LOGIC;
           btnD : in STD_LOGIC;
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

component MUX8x16 is
  Port ( A0, A1, A2, A3, A4, A5, A6, A7 : in STD_LOGIC_VECTOR (15 downto 0);
         B0, B1, B2 : in STD_LOGIC;
         S : out STD_LOGIC_VECTOR (15 downto 0));
end component;

component decoder_out is
    Port ( selector : in std_logic_vector (15 downto 0);
           load_out : in  std_logic;
           load_dis : out  std_logic;
           load_led : out  std_logic);
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
            sd_in, spc, inc_sp, dec_sp, load_out: out std_logic -- sd_in, spc, inc_sp and dec_sp nueva singal
        );
end component;

component Debouncer is
    Port ( clk : in  std_logic;
           signalin : in  std_logic;
           signalout : out  std_logic);
end component;

component Timer is
    Port ( clk : in STD_LOGIC;
           seconds : out STD_LOGIC_VECTOR (15 downto 0);
           mseconds: out STD_LOGIC_VECTOR (15 downto 0);
           useconds: out STD_LOGIC_VECTOR (15 downto 0));
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
signal segundos, msegundos, usegundos: std_logic_vector (15 downto 0):= (others => '0');
signal input: std_logic_vector (15 downto 0):= (others => '0');
signal botones: std_logic_vector (15 downto 0):= (others => '0');
signal load_out, load_dis, load_led: std_logic:= '0';
signal display_value, led_value: std_logic_vector (15 downto 0):= (others => '0');

signal AddCin, AddCout: std_logic:= '0';
-- A definir 
-- A�adir a control unit "inc_sp", "dec_sp", "sel_mux_s(0:1)", "sel_mux_pc", "sel_d_in"

begin
    clock_speed <= "00";
    lit16 <= instruccion(15 downto 0);
    lit12 <= instruccion(11 downto 0);
    out_add_16 <= ("0000" & out_add);
    BotonCentral: Debouncer port map (clock, btnC, botones(0));
    BotonUpper: Debouncer port map (clock, btnU, botones(1));
    BotonRight: Debouncer port map (clock, btnR, botones(2));
    BotonLeft: Debouncer port map (clock, btnL, botones(3));
    BotonDown: Debouncer port map (clock, btnD, botones(4));
    
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
    MUXA: MUX4x16 port map (reg_a_out, "0000000000000001", input, "0000000000000000", sel_mux_a(0), sel_mux_a(1), mux_a_out);
    MUXB: MUX4x16 port map (reg_b_out, lit16, ram_data_out, "0000000000000000", sel_mux_b(0), sel_mux_b(1), mux_b_out);
    
    UnidadLogicaAritmetica: ALU port map (clock, mux_a_out, mux_b_out, sel_alu, resultado, new_stats);
    Estatus: Status port map (clock, new_stats, stats);
    
    CU: Control_unit port map (instruccion(35 downto 16), stats, ram_w, load_pc, load_reg_a, load_reg_b, sel_mux_a, sel_mux_b, sel_alu, sel_mux_s, sel_d_in, sel_mux_pc, inc_sp, dec_sp, load_out);
    
    TimerIN: Timer port map (clk, segundos, msegundos, usegundos);
    MuxIN: MUX8x16 port map (sw, botones, segundos, msegundos, usegundos, "0000000000000000","0000000000000000","0000000000000000", lit12(0), lit12(1), lit12(2), input);
    
    Decoder_Outt: decoder_out port map (mux_b_out, load_out, load_dis, load_led);
    RegistroDisplay: Reg port map (clock, load_dis, '0', '0', reg_a_out, display_value);
    RegistroLEDs: Reg port map (clock, load_led, '0', '0', reg_a_out, led_value);
    
    Displayer: Display_Controller port map (display_value(15 downto 12), display_value(11 downto 8), display_value(7 downto 4), display_value(3 downto 0), clk, seg, an);
    
    led(0) <= led_value(0);
    led(1) <= led_value(1);
    led(2) <= led_value(2);
    led(3) <= led_value(3);
    led(4) <= led_value(4);
    led(5) <= led_value(5);
    led(6) <= led_value(6);
    led(7) <= led_value(7);
    led(8) <= led_value(8);
    led(9) <= led_value(9);
    led(10) <= led_value(10);
    led(11) <= led_value(11);
    led(12) <= led_value(12);
    led(13) <= led_value(13);
    led(14) <= led_value(14);
    led(15) <= led_value(15);

end Behavioral;

