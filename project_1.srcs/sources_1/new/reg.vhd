----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 02:32:00 PM
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (23 downto 0);
           Q : out STD_LOGIC_VECTOR (23 downto 0)); -- 23:12 real 11:0 Imaginario
end reg;

architecture Behavioral of reg is

begin
PROCESS(clk)
    BEGIN
        IF clk'event and clk ='1' then
            IF rst='1' then
                Q<=(others => '0');
            ELSIF en='1' then
                Q <=D;
            end if;
        end if;
    END PROCESS;

end Behavioral;
