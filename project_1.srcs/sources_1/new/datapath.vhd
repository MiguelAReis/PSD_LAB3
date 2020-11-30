----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2020 05:17:24 PM
-- Design Name: 
-- Module Name: datapath - Behavioral
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

entity datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           final : out STD_LOGIC;
           selectReg : in STD_LOGIC_VECTOR (1 downto 0);
           memIn : in STD_LOGIC_VECTOR (31 downto 0);
           maxID : out STD_LOGIC_VECTOR (3 downto 0);
           minID : out STD_LOGIC_VECTOR (3 downto 0);
           valueOutR :out STD_LOGIC_VECTOR (31 downto 0);
           valueOutI :out STD_LOGIC_VECTOR (31 downto 0);
           averagesOutR: out STD_LOGIC_VECTOR (31 downto 0);
           averageOutI: out STD_LOGIC_VECTOR (31 downto 0));
end datapath;

architecture Behavioral of datapath is
SIGNAL en0, en1, en2: STD_LOGIC;
SIGNAL reg0, reg1, reg2 :STD_LOGIC_VECTOR(23 downto 0);
SIGNAL memConverted:STD_LOGIC_VECTOR (23 downto 0);
SIGNAL A, B, C, D, E, F, G, H: STD_LOGIC_VECTOR(11 downto 0);
SIGNAL mult0, mult1, mult2, mult3:STD_LOGIC_VECTOR (23 downto 0);
SIGNAL sub0, sub1:STD_LOGIC_VECTOR (23 downto 0);
SIGNAL enDelayed:STD_LOGIC;
SIGNAL detR, detI:STD_LOGIC_VECTOR (31 downto 0);
SIGNAL avgR, avgI:STD_LOGIC_VECTOR (31 downto 0);

COMPONENT reg
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (23 downto 0);
           Q : out STD_LOGIC_VECTOR (23 downto 0));
END COMPONENT;

COMPONENT mult is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           Q : out STD_LOGIC_VECTOR (23 downto 0));
end COMPONENT;

COMPONENT subtractor is
    Port ( clk : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (23 downto 0);
           B : in STD_LOGIC_VECTOR (23 downto 0);
           Q : out STD_LOGIC_VECTOR (23 downto 0));
end COMPONENT;
           
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
           minID: out STD_LOGIC_VECTOR (3 downto 0);
           maxID: out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;      

COMPONENT average is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en  : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;    

COMPONENT selRegConverter is
    Port ( D : in STD_LOGIC_VECTOR (1 downto 0);
           Q0 : out STD_LOGIC;
           Q1 : out STD_LOGIC;
           Q2 : out STD_LOGIC);
end COMPONENT; 

COMPONENT delay is
    Port ( clk : in STD_LOGIC;
           D : in STD_LOGIC;
           Q: out STD_LOGIC);
END COMPONENT;



begin
memConverted <=memIN(27 downto 16)&memIN(11 downto 0);
A<=reg0(23 downto 12);
B<=reg0(11 downto 0);
C<=reg1(23 downto 12);
D<=reg1(11 downto 0);
E<=reg2(23 downto 12);
F<=reg2(11 downto 0);
G<=memConverted(23 downto 12);
H<=memConverted(11 downto 0);

detR <= SXT(sub0&"0000",32);
detI <= SXT(sub1&"0000",32);
valueOutR<=detR;
valueOutI<=detI;

final<= enDelayed;

inst_selRegConverter: selRegConverter port map(
    D => selectReg,
    Q0 => en0,
    Q1 => en1,
    Q2 => en2);

inst_reg0 : reg port map(
    clk => clk, 
    rst => rst,
    en => en0,
    D => memConverted,
    Q => reg0);

inst_reg1 : reg port map(
    clk => clk, 
    rst => rst,
    en => en1,
    D => memConverted,
    Q => reg1);

inst_reg2 : reg port map(
    clk => clk, 
    rst => rst,
    en => en2,
    D => memConverted,
    Q => reg2);

inst_mult0 : mult port map(
    clk => clk,
    A => A,
    B => G,
    Q => mult0);

inst_mult1 : mult port map(
    clk => clk,
    A => C,
    B => E,
    Q => mult1);

inst_mult2 : mult port map(
    clk => clk,
    A => B,
    B => H,
    Q => mult2);

inst_mult3 : mult port map(
    clk => clk,
    A => D,
    B => F,
    Q => mult3);
    
inst_sub0: subtractor port map(
    clk => clk,
    A => mult0,
    B => mult1,
    Q => sub0);
    
inst_sub1: subtractor port map(
    clk => clk,
    A => mult2,
    B => mult3,
    Q => sub1);
    
inst_adder0: adder port map(
    clk => clk,
    rst => rst,
    A => sub0,
    B => sub1,
    en => enDelayed,
    minID => minID ,
    maxID =>maxID);
    
inst_delay0: delay port map(
    clk => clk,
    D => en2,
    Q => enDelayed);

inst_average0: average port map(
    clk => clk,
    rst  => rst,
    en   => enDelayed,
    D  => detR,
    Q  => averageOutR);
    
inst_average1: average port map(
    clk => clk,
    rst  => rst,
    en   => enDelayed,
    D  => detI,
    Q  => averageOutI);
    

end Behavioral;
