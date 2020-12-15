library ieee;
library UNISIM;
library UNIMACRO;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use UNISIM.Vcomponents.all;
use UNIMACRO.vcomponents.all;


entity memIN is
  port (
    clk    : in  std_logic;
    addr   : in  std_logic_vector(5 downto 0);
    memOut : out std_logic_vector(31 downto 0)
    );
end memIN;


architecture behavioural of MemIN is
  signal dout: std_logic_vector(31 downto 0);
  signal addr9 : std_logic_vector(9 downto 0);
begin

addr9 <="0000"&addr;
  MEM_in : BRAM_SINGLE_MACRO
    generic map (          -- memory initialization
      BRAM_SIZE => "36Kb", -- Target BRAM, "18Kb" or "36Kb"
      DEVICE => "7SERIES", -- Target Device: "VIRTEX5", "7SERIES", "VIRTEX6, "SPARTAN6"
      WRITE_WIDTH => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      READ_WIDTH  => 32,   -- Valid values are 1-72 (37-72 only valid when BRAM_SIZE="36Kb")
      -- Initialize memory predefined data
      INIT_00 => X"D43405D9CF5B02A3B46604E5A9BE0173DBA6055FC00908C4B76B0976A8E30236",
INIT_01 => X"D8E60F19C636017BB3870C78A3AF080AD6320E13CA090937B7910774AFDF0861",
INIT_02 => X"DADD0002C0230BEDB7B90504A5A90D80D91A02D4C9160435B88F03BAA3B10052",
INIT_03 => X"DB02051FC16D04B3BBCD0BE9A5B30FF2DC6B0F55CBA60DA9B7770E58A44E026E",
INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000001",
INIT_06 => X"000000000000000000000000000000000000000000000000000000005FD0B3CE",
INIT_07 => X"0000000000000000000000000000000000000000000000000000001607513038" 
 

    )
    port map (
      CLK   => clk,         -- Clock
      ADDR  => addr9,        -- 9-bit Address Input, width defined by read/write port depth
      DI    => x"00000000", -- 32-bit Data Input, width defined by WRITE_WIDTH parameter
      DO    => memOut,       -- 32-bit Data Output, width defined by READ_WIDTH parameter
      EN    => '1',         -- 1-bit RAM Enable Input
      WE    => "0000",      -- Write Enable Input, width defined by write port depth
      REGCE => '0',         -- 1-bit Input, output register enable
      RST   => '0'          -- 1-bit Input reset
      );


end behavioural;
