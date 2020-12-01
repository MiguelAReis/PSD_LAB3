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
      INIT_00 => X"D70902E1C1E702DBB5760C88ADB70C37D213060ACAF70DD1BE2301EDAD520469",
      INIT_01 => X"D1320AFDCDAA043CB6E90FE6A3C605E4DF1B0D88C5EF0D29BD9A0748A7EC06EB",
      INIT_02 => X"DFFD09E5C1F90E70B7670D1CAB340F1DD9A70ADECD270EFDBCEA039CA8A50F55",
      INIT_03 => X"DED50C9EC3F90F9EBE6C03D8A62E0FBCD8D30E86CAC00049B12E0B4BA55B0D97",
      INIT_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_05 => X"0000000000000000000000000000000000000000000000000000000000000001",
      INIT_06 => X"000000000000000000000000000000000000000000000000000000005FC565D1",
      INIT_07 => X"0000000000000000000000000000000000000000000000000000001606772177" 

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
