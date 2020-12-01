----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 10:26:38 PM
-- Design Name: 
-- Module Name: datapath_tb - Behavioral
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

entity datapath_tb is
--  Port ( );
end datapath_tb;

architecture Behavioral of datapath_tb is
COMPONENT datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           selectReg : in STD_LOGIC_VECTOR (1 downto 0);
           memIn : in STD_LOGIC_VECTOR (31 downto 0);
           maxID : out STD_LOGIC_VECTOR (3 downto 0);
           minID : out STD_LOGIC_VECTOR (3 downto 0);
           valueOutR :out STD_LOGIC_VECTOR (31 downto 0);
           valueOutI :out STD_LOGIC_VECTOR (31 downto 0);
           averageOutR: out STD_LOGIC_VECTOR (31 downto 0);
           averageOutI: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

  SIGNAL clk : STD_LOGIC :='0';
  SIGNAL rst : STD_LOGIC :='0';
  SIGNAL selectReg : STD_LOGIC_VECTOR (1 downto 0):= (OTHERS =>'0');
  SIGNAL memIn  : STD_LOGIC_VECTOR (31 downto 0):= (OTHERS =>'0');
  SIGNAL selectOut : STD_LOGIC :='0';
  SIGNAL maxID  : STD_LOGIC_VECTOR (3 downto 0):= (OTHERS =>'0');
  SIGNAL minID : STD_LOGIC_VECTOR (3 downto 0):= (OTHERS =>'0');
  SIGNAL valueOutR  : STD_LOGIC_VECTOR (31 downto 0):= (OTHERS =>'0');
  SIGNAL valueOutI : STD_LOGIC_VECTOR (31 downto 0):= (OTHERS =>'0');
  SIGNAL averageOutR : STD_LOGIC_VECTOR (31 downto 0):= (OTHERS =>'0');
  SIGNAL averageOutI : STD_LOGIC_VECTOR (31 downto 0):= (OTHERS =>'0');
  
  CONSTANT clk_period: time := 10ns;

begin

uut : datapath PORT MAP (
   clk => clk,
   rst  => rst,
   selectReg  => selectReg,
   memIn  => memIn,
   maxID  => maxID,
   minID  => minID,
   valueOutR  => valueOutR,
   valueOutI  => valueOutI,
   averageOutR => averageOutR,
   averageOutI => averageOutI);

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
                    
                    
--                        | Real     |    |   Imag   |
            memIn <= "00000000000010010000000000011000" AFTER 10ns,
                     X"AD520469" AFTER 60ns, --A + B
                     X"BE2301ED" AFTER 70ns, --C + D
                     X"CAF70DD1" AFTER 80ns, --E + F
                     X"D213060A" AFTER 90ns, --G + H
                     "00000000000000000000000000000000" AFTER 100ns;
                     
            
            selectReg <= "01" AFTER 60ns,
                         "10" AFTER 70ns,
                         "11" AFTER 80ns,
                         "00" AFTER 90ns;
            
                    
                    
                    
        WAIT;
        END PROCESS;



end Behavioral;
