----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 02:43:29 PM
-- Design Name: 
-- Module Name: mult - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           Q : out STD_LOGIC_VECTOR (23 downto 0));
end mult;

architecture Behavioral of mult is

begin
PROCESS(clk)
BEGIN
    IF clk'event and clk ='1' then
        Q<=A*B;
    END IF;
END PROCESS;



end Behavioral;
