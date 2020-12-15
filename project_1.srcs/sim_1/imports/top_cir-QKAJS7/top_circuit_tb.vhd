
library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;


entity top_circuit_tb is
end entity top_circuit_tb;


architecture test of top_circuit_tb is
  component top_circuit is
  port (clk      : in  std_logic;
        btns    : in  STD_LOGIC_VECTOR(2 downto 0);
        LED      : out std_logic_vector (15 downto 0);
        UART_TXD : out std_logic
        );
  end component top_circuit;

  
  signal btns      : std_logic_vector (2 downto 0)  := (others => '0');
  signal clk      : std_logic                      := '0';
  signal LED      : std_logic_vector (15 downto 0);
  signal UART_TXD : std_logic;

  -- Clock period definitions
  constant clk_period : time := 10 ns;


begin  -- architecture test

  top_circuit_1 : top_circuit
    port map (
      btns      => btns,
      clk      => clk,
      LED      => LED,
      UART_TXD => UART_TXD);

-- Clock process definitions
  clk_process : process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process;


  -- Stimulus process
  stim_proc : process
  begin
    -- hold reset state for 100 ns.
    wait for 100 ns;

    wait for clk_period*10;


    -- insert stimulus here
    btns(2) <= '1' after 1 us,          -- reset btnD
              '0' after 1.7 us;
    --'1' after 50 ms,
    --'0' after 52 ms;

    btns(0) <= '1' after 3 us,          -- start working btnR
              '0' after 3.7 us;
    --'1' after 80 ms,
    --'0' after 81 ms;

    btns(1) <= '1' after 2.0010 ms,          -- load from mem btnU
              '0' after 2.0017 ms;


    wait;
  end process;



end architecture test;
