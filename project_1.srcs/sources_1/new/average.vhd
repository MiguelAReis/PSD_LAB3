----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 04:45:45 PM
-- Design Name: 
-- Module Name: average - Behavioral
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
use IEEE.STD_LOGIC_SIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity average is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en  : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end average;

architecture Behavioral of average is
SIGNAL sum :STD_LOGIC_VECTOR(31 downto 0);

begin
PROCESS(clk)
    BEGIN
        IF clk'event and clk ='1' then
            IF rst='1' then
                sum<=(others => '0');
            ELSIF en='1' then
                sum <=sum +D;
            end if;
        end if;
    END PROCESS;
Q<= SXT(sum(31 downto 4),32); -- dividir por 8

end Behavioral;
