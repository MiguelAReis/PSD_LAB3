----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/28/2020 01:02:17 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable : in STD_LOGIC;
           counterOut : out STD_LOGIC_VECTOR (5 downto 0));
end counter;

architecture Behavioral of counter is
Signal count : STD_LOGIC_VECTOR (5 downto 0);

begin

    PROCESS(clk, rst)
     BEGIN
        if clk'event and clk ='1' then
            if (rst = '1') then
                count <= (others => '0');
            elsif (enable = '1') then
                count <= count+1;
            end if;
        end if;
    END PROCESS;

counterOut<= count;    
   


end Behavioral;
