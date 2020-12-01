----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2020 11:25:47 PM
-- Design Name: 
-- Module Name: topCircuit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity topCircuit_tb is
--  Port ( );
end topCircuit_tb;



architecture Behavioral of topCircuit_tb is

COMPONENT topCircuit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           maxID : out STD_LOGIC_VECTOR(3 downto 0);
           minID : out STD_LOGIC_VECTOR(3 downto 0));
end COMPONENT;

  SIGNAL clk : std_logic :='0';
  SIGNAL rst : std_logic :='0';
  SIGNAL start : std_logic :='0';
  SIGNAL maxID : std_logic_VECTOR (3 downto 0) :="0000";
  SIGNAL minID : std_logic_VECTOR (3 downto 0) :="0000";

  
  CONSTANT clk_period: time := 10ns;

begin

uut : topCircuit PORT MAP(
    clk => clk,
    rst => rst,
    start => start,
    maxID => maxID,
    minID => minID);




clk_process : PROCESS
        BEGIN
            clk <= '0';
            WAIT FOR clk_period/2;
            clk <= '1';
            WAIT FOR clk_period/2;
        END PROCESS;
    
     stim_proc : PROCESS
        BEGIN
        
            rst <=  '1' AFTER 0 ns,
                    '0' AFTER 50 ns;
                    
            start <= '1' AFTER 70 ns,
                     '0' AFTER 90 ns;        
        WAIT;
        END PROCESS;


end Behavioral;
