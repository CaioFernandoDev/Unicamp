library ieee;
use ieee.std_logic_1164.all;

entity dec2_to_4 is
  port(en, w1, w0: in std_logic;
       y3, y2, y1, y0: out std_logic);
end dec2_to_4;

architecture rtl of dec2_to_4 is
begin
	y0 <= en and (not w1 and not w0);
   y1 <= en and (not w1 and w0);
   y2 <= en and (w1 and not w0);
   y3 <= en and (w1 and w0);
end rtl;

