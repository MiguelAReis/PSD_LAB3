----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 07:08:56 PM
-- Design Name: 
-- Module Name: adder_tb - Behavioral
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

entity adder_tb is
--  Port ( );
end adder_tb;

architecture Behavioral of adder_tb is

SIGNAL clk : std_logic :='0';
SIGNAL rst : std_logic :='0';
SIGNAL en : std_logic :='0';
SIGNAL A : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');
SIGNAL B : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');

SIGNAL minR : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');
SIGNAL minI : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');
SIGNAL maxR : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');
SIGNAL maxI : STD_LOGIC_VECTOR (23 downto 0):= (OTHERS =>'0');
SIGNAL maxID : STD_LOGIC_VECTOR (3 downto 0):= (OTHERS =>'0');
SIGNAL minID : STD_LOGIC_VECTOR (3 downto 0):= (OTHERS =>'0');

   CONSTANT clk_period: time := 10ns;

  
COMPONENT adder is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (23 downto 0);
           B : in STD_LOGIC_VECTOR (23 downto 0);
           en : in STD_LOGIC;
           minR: out STD_LOGIC_VECTOR (23 downto 0);
           minI: out STD_LOGIC_VECTOR (23 downto 0);
           maxR: out STD_LOGIC_VECTOR (23 downto 0);
           maxI: out STD_LOGIC_VECTOR (23 downto 0);
           maxID: out STD_LOGIC_VECTOR (3 downto 0);
           minID: out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;
begin

uut : adder port map (
       clk => clk,
       rst => rst,
       A => A,
       B => B,
       en =>  en,
       minR=> minR ,
       minI => minI,
       maxR => maxR,
       maxI => maxI, 
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
                    '0' AFTER 40 ns;
                    
            A <= "000000000000000000000010" AFTER 60 ns,
                 "000000000000000000001000" AFTER 70 ns,
                 "000000000000000000000001" AFTER 140 ns;
                   
            B <= "000000000000000000000010" AFTER 60 ns,
                 "000000000000000000001000" AFTER 70 ns,
                 "000000000000000000000001" AFTER 140 ns;
            en <= '1' AFTER 60ns,
                  '0' AFTER 70 ns,
                  '1' AFTER 120 ns,
                  '0' AFTER 130 ns,
                  '1' AFTER 150 ns,
                  '0' AFTER 160 ns;      
                    
        WAIT;
        END PROCESS;


end Behavioral;
