----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 02:43:29 PM
-- Design Name: 
-- Module Name: adder - Behavioral
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
use IEEE.STD_LOGIC_ARITH.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity adder is
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
           minId: out STD_LOGIC_VECTOR (3 downto 0));
end adder;

architecture Behavioral of adder is
SIGNAL max, min :STD_LOGIC_VECTOR(31 downto 0);
SIGNAL sum : STD_LOGIC_VECTOR (31 downto 0);
signal ID : STD_LOGIC_VECTOR (3 downto 0);

begin
PROCESS(clk)
BEGIN
    IF clk'event and clk ='1' then
        IF rst ='1' then
            minR<= (23 => '0', others =>'1');
            minI<= (23 => '0', others =>'1');
            maxR<= (others =>'0');
            maxI <= (others =>'0');
            max <= (others =>'0');
            min <= (31 => '0', others =>'1');
            maxID <= (others =>'0');
            minID <= (others =>'0'); 
            ID <= (others =>'0');
        ELSIF en ='1' then
            ID <=ID+'1';    
            IF sum > max then
                max <= sum;
                maxR <= A;
                maxI <= B;
                maxID <=ID;
            END IF;
            IF sum < min then
                min <= sum;
                minR <= A;
                minI <= B;
                minID <=ID;
            END IF;
        END IF;
    END IF;
END PROCESS;

PROCESS(A,B)
BEGIN
    sum <= SXT(abs(A)+abs(B),32);
END PROCESS;


end Behavioral;
