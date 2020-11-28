----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 05:40:30 PM
-- Design Name: 
-- Module Name: selRegConverter - Behavioral
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

entity selRegConverter is
    Port ( D : in STD_LOGIC_VECTOR (1 downto 0);
           Q0 : out STD_LOGIC;
           Q1 : out STD_LOGIC;
           Q2 : out STD_LOGIC);
end selRegConverter;

architecture Behavioral of selRegConverter is

begin

PROCESS(D)
    BEGIN
    Q0 <= '0';
    Q1 <='0';
    Q2 <='0';
        IF D = "01" then
            Q0 <='1';
        ELSIF D= "10" then
            Q1 <='1';
        ELSIF D ="11" then
            Q2 <= '1';
        END IF;
        
END PROCESS;


end Behavioral;
