
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity StateMachine is
    Port ( clk : in STD_LOGIC; 
		   rst: in STD_LOGIC;
		   start: in STD_LOGIC;
		   final: in STD_LOGIC;
		   var : in STD_LOGIC;
		   enINCounter : out STD_LOGIC;
		   enOUTCounter : out STD_LOGIC;
		   muxSel : out STD_LOGIC_VECTOR (1 downto 0));
end StateMachine;

architecture Behavioral of StateMachine is
    TYPE STATE_TYPE is (s0,s1,s2,s3,s4,s5,s6);
    SIGNAL state : STATE_TYPE;

begin
    PROCESS (clk, rst)
    BEGIN
        IF (clk'EVENT AND clk ='1') THEN
            IF rst = '1' THEN
                state <=s0;
            ELSE
            CASE state IS 
                WHEN s0 =>
                    IF start = '1' THEN
                        state <= s1;
                    ELSE
                        state <= s0;
                    END IF;
                WHEN s1 =>
                    IF final = '1' THEN
                        state <= s1;
                    ELSE
                        state <= s2;
                    END IF;
                WHEN s2 =>
                    state <= s3;
                WHEN s3 =>
                    IF var = '1' THEN
                        state <= s1;
                    ELSE
                        state <= s4;
                    END IF;
                WHEN s4=>
                    state <= s5;
				WHEN s5=>	
					state <= s6;
                WHEN OTHERS =>
                    state <= s6;
             END CASE;
             END IF;
        END IF;
    END PROCESS;
    
        PROCESS (state)
    BEGIN
        CASE state IS 
            WHEN s0=> 
				enINCounter <= '1';
				enOUTCounter <= '0';
				muxSel <= "XX";
			WHEN s1=>
				enINCounter <= '1';
				enOUTCounter <= '1';
				muxSel <= "00";
			WHEN s2=>
				enINCounter <= '1';
				enOUTCounter <= '1';
				muxSel <= "00";
			WHEN s3=>
				enINCounter <= '0';
				enOUTCounter <= '0';
				muxSel <= "01";
			WHEN s4=>
				enINCounter <= '0';
				enOUTCounter <= '1';
				muxSel <= "10";
			WHEN s5=>
				enINCounter <= '0';
				enOUTCounter <= '1';
				muxSel <= "11";
			WHEN s6=>
				enINCounter <= '0';
				enOUTCounter <= '0';
				muxSel <= "XX";
        END CASE;
    END PROCESS;
    
end Behavioral;
