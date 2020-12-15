---------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
--The IEEE.std_logic_unsigned contains definitions that allow
--std_logic_vector types to be used with the + operator to instantiate a
--counter.
use IEEE.std_logic_unsigned.all;

use IEEE.std_logic_misc.all;


entity top_circuit is
  port (clk      : in  std_logic;
        btns    : in  STD_LOGIC_VECTOR(2 downto 0);
        LED      : out std_logic_vector (15 downto 0);
        UART_TXD : out std_logic
        );
end top_circuit;

architecture Behavioral of top_circuit is


component MemOuT is
port (
  DataWRA : in  std_logic_vector(31 downto 0);
  AddrWRA : in  std_logic_vector(7 downto 0);
  ClkWRA  : in  std_logic;
  WeWRA   : in  std_logic;
  DataRDB : out std_logic_vector(7 downto 0);
  AddrRDB : in  std_logic_vector(9 downto 0);
  ClkRDB  : in  std_logic);
end component MemOuT;


component circuit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           maxID : out STD_LOGIC_VECTOR(3 downto 0);
           minID : out STD_LOGIC_VECTOR(3 downto 0);
           we: out STD_LOGIC;
           dataIN : out std_logic_vector(31 downto 0);
           addr: out  std_logic_vector(7 downto 0) );
end component;


  component debouncer
    generic(
      DEBNC_LOG_CLOCKS : integer;
      PORT_WIDTH       : integer);
    port(
      SIGNAL_I : in  std_logic_vector(2 downto 0);
      CLK_I    : in  std_logic;
      SIGNAL_O : out std_logic_vector(2 downto 0)
      );
  end component;

component UART_TX_KB is
port (
  CLK      : in  std_logic;
  RESET    : in  std_logic;
  START_TX : in  std_logic;
  RD_ADDR  : out std_logic_vector (9 downto 0);
  RD_DATA  : in  std_logic_vector (7 downto 0);
  TX_OUT   : out std_logic);
end component UART_TX_KB;


-- buttons signals
  signal rst  : std_logic;
  signal start  : std_logic;
  signal load :std_logic;
  signal btnsD : std_logic_vector(2 downto 0);


-- memOut signals
  signal dataOut : std_logic_vector(31 downto 0);
  signal addrOut : std_logic_vector(7 downto 0);
  signal weOut   : std_logic;

-- Led signal
  signal statusLeds : std_logic_vector(15 downto 0);
  SIGNAL maxLED : std_logic_vector(3 downto 0);
  SIGNAL minLED : std_logic_vector(3 downto 0);


-- UART_TX_KB  signals
  signal dataSend : std_logic_vector (7 downto 0);
  signal readAddr : std_logic_vector (9 downto 0);




begin

LED <= "00000"&maxLed(2 downto 0)&"00000"&minLed(2 downto 0);
    
  inst_circuit : circuit port map(
           clk => clk ,
           rst => rst ,
           start => start ,
           maxID => maxLED ,
           minID => minLED ,
           we => weOut ,
           dataIN => dataOut ,
           addr=> addrOut );

  debouncer_1 : debouncer
    generic map(
      DEBNC_LOG_CLOCKS => 4,
      PORT_WIDTH       => 3)
    port map(
      SIGNAL_I => btns,
      CLK_I    => clk,
      SIGNAL_O => btnsD);

start <= btns(0);
load <= btns(1);
rst <= btns(2);

  -- Output memory
  MemOuT_1 : MemOuT
    port map (
      DataWRA => dataOut,
      AddrWRA => addrOut,
      clkWRA  => CLK,
      WeWRA   => weOut,
      DataRDB => dataSend,
      AddrRDB => readAddr,
      clkRDB  => CLK);



  -- circuit to upload output memory to the PC using UART interface (via USB)
  UART_TX_KB_1 : UART_TX_KB
    port map (
      CLK      => CLK,
      RESET    => rst,
      START_TX => load,
      RD_ADDR  => readAddr,
      RD_DATA  => dataSend,
      TX_OUT   => UART_TXD);



end Behavioral;
