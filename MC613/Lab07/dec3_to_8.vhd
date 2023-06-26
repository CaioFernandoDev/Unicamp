library ieee;
use ieee.std_logic_1164.all;

entity dec3_to_8 is
  port (
    w : in std_logic_vector(2 downto 0);
    y : out std_logic_vector(7 downto 0)
  );
end dec3_to_8;

architecture rtl of dec3_to_8 is
begin
	with w select
		y <=	"10000000" when "000", -- 0
				"01000000" when "001", -- 1
				"00100000" when "010", -- 2
				"00010000" when "011", -- 3
				"00001000" when "100", -- 4
				"00000100" when "101", -- 5
				"00000010" when "110", -- 6
				"00000001" when "111", -- 7
				"00000000" when others;
end rtl;

