library ieee;
use ieee.std_logic_1164.all;

entity xbar_gen is
	generic (N : integer := 8);
	port(s: in std_logic_vector (N-1 downto 0);
       y1, y2: out std_logic
	);
end xbar_gen;

architecture rtl of xbar_gen is
	signal x1, x2 : std_logic_vector(N downto 0);

	component xbar_v1 is
		port(
			x1, x2, s: in std_logic;
			y1, y2 : out std_logic
		);
	end component;

begin
	x1(0) <= '1';
	x2(0) <= '0';
	
	gen : for i in 0 to N-1 generate
		xbar : xbar_v1 port map(x1(i), x2(i), s(i), x1(i+1), x2(i+1));
	end generate;
	
	y1 <= x1(N);
	y2 <= x2(N);
end rtl;

