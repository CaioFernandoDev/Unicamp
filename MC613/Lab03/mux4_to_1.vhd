library ieee;
use ieee.std_logic_1164.all;

entity mux4_to_1 is
  port(d3, d2, d1, d0 : in std_logic;
       sel : in std_logic_vector(1 downto 0);
       output : out std_logic);
end mux4_to_1;

architecture rtl of mux4_to_1 is
	signal y: std_logic_vector(3 downto 0);
begin
		decoder: entity work.dec2_to_4
			port map(
				en => '1',
				w1 => sel(1), w0 => sel(0),
				y3 => y(3), y2 => y(2), y1 => y(1), y0 => y(0)
			);
			
		extra_logic: entity work.extra_logic
			port map(
				w3 => d3, w2 => d2, w1 => d1, w0 => d0,
                y3 => y(3), y2 => y(2), y1 => y(1), y0 => y(0),
                f  => output
			);

end rtl;

