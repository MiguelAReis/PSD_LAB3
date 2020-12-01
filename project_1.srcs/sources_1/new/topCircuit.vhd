----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2020 10:36:54 PM
-- Design Name: 
-- Module Name: topCircuit - Behavioral
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

entity topCircuit is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           start : in STD_LOGIC;
           maxID : out STD_LOGIC_VECTOR(3 downto 0);
           minID : out STD_LOGIC_VECTOR(3 downto 0));
end topCircuit;

architecture Behavioral of topCircuit is

SIGNAL enINCounter, enOUTCounter : STD_LOGIC;
SIGNAL final : STD_LOGIC;
SIGNAL INCount, OUTCount : STD_LOGIC_VECTOR(5 downto 0);
SIGNAL muxSel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL memINOut,muxOut, memOutOut, valueOutR, valueOutI, valueOutIDelayed, averageOutR, averageOutI: STD_LOGIC_VECTOR(31 downto 0);

COMPONENT StateMachine is
    Port ( clk : in STD_LOGIC; 
		   rst: in STD_LOGIC;
		   start: in STD_LOGIC;
		   final: in STD_LOGIC;
		   var : in STD_LOGIC;
		   enINCounter : out STD_LOGIC;
		   enOUTCounter : out STD_LOGIC;
		   muxSel : out STD_LOGIC_VECTOR (1 downto 0));
end COMPONENT;

COMPONENT counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable : in STD_LOGIC;
           counterOut : out STD_LOGIC_VECTOR (5 downto 0));
end COMPONENT;

COMPONENT memIN is
  port (
    clk    : in  std_logic;
    addr   : in  std_logic_vector(5 downto 0);
    memOut : out std_logic_vector(31 downto 0)
    );
end COMPONENT;

COMPONENT memOUT is
  port (
    clk     : in  std_logic;
    addr    : in  std_logic_vector(5 downto 0);
    we      : in  std_logic;
    dataIN  : in  std_logic_vector(31 downto 0);
    dataOUT : out  std_logic_vector(31 downto 0)
    );
end COMPONENT;

COMPONENT datapath is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           final : out STD_LOGIC;
           selectReg : in STD_LOGIC_VECTOR (1 downto 0);
           memIn : in STD_LOGIC_VECTOR (31 downto 0);
           maxID : out STD_LOGIC_VECTOR (3 downto 0);
           minID : out STD_LOGIC_VECTOR (3 downto 0);
           valueOutR :out STD_LOGIC_VECTOR (31 downto 0);
           valueOutI :out STD_LOGIC_VECTOR (31 downto 0);
           averageOutR: out STD_LOGIC_VECTOR (31 downto 0);
           averageOutI: out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT multiplexer is
    Port ( inBus0 : in STD_LOGIC_VECTOR (31 downto 0);
           inBus1 : in STD_LOGIC_VECTOR (31 downto 0);
           inBus2 : in STD_LOGIC_VECTOR (31 downto 0);
           inBus3 : in STD_LOGIC_VECTOR (31 downto 0);
           outBus : out STD_LOGIC_VECTOR (31 downto 0);
           address : in STD_LOGIC_VECTOR (1 downto 0));
end COMPONENT;

COMPONENT reg32 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en: in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (31 downto 0);
           Q : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

begin

inst_StateMachine : StateMachine port map(
    clk => clk,
	rst => rst,
	start => start,
    final => final,
    var => INCount(5), 
    enINCounter => enINCounter,
    enOUTCounter => enOUTCounter,
    muxSel => muxSel);

inst_counter0 : counter port map(
    clk => clk,
    rst  => rst,
    enable  => enINCounter,
    counterOut => INCount);
    
inst_counter1 : counter port map(
    clk => clk,
    rst  => rst,
    enable  => enOUTCounter,
    counterOut => OUTCount);
    
inst_memIN : memIN port map(
    clk   => clk,
    addr   => InCount,
    memOut => memINOut);
    
inst_memOut : memOut port map(
    clk     => clk,
    addr   => OUTCount,
    we      => enOUTCounter,
    dataIN  => muxOut,
    dataOUT => memOutOut);
    
inst_multiplexer : multiplexer port map(
    inBus0 => valueOutR,
    inBus1 => valueOutIDelayed,
    inBus2 => averageOutR,
    inBus3 => averageOutI,
    outBus => muxOut,
    address => muxSel);
    
inst_reg32: reg32 port map(
    clk => clk,
    rst => rst,
    en=> '1',
    D => valueOutI,
    Q => valueOutIDelayed);
    
inst_datapath: datapath port map(
    clk => clk,
    rst => rst,
    final => final,
    selectReg => InCount(1 downto 0),
    memIn => memINOut,
    maxID => maxID,
    minID => minID,
    valueOutR => valueOutR,
    valueOutI => valueOutI,
    averageOutR => averageOutR,
    averageOutI => averageOutI);

end Behavioral;
