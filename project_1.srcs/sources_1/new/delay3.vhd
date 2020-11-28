----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 06:53:51 PM
-- Design Name: 
-- Module Name: delay3 - Behavioral
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

entity delay3 is
    Port ( clk : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
end delay3;

architecture Behavioral of delay3 is

SIGNAL n0,n1,n2,n3 : STD_LOGIC;
begin
PROCESS(clk)
    BEGIN
        IF clk'event and clk ='1' then
            n0 <= D;
            n1 <= n0;
            n2 <= n1;
            n3 <= n2;
            Q <= n3;
        END IF;
END PROCESS;
end Behavioral;
