-- brief : lab05 - question 2

library ieee;
use ieee.std_logic_1164.all;

entity cla_8bits is
  port(
    x    : in  std_logic_vector(7 downto 0);
    y    : in  std_logic_vector(7 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(7 downto 0);
    cout : out std_logic
  );
end cla_8bits;

architecture rtl of cla_8bits is
	signal g: std_logic_vector(7 downto 0);
	signal p: std_logic_vector(7 downto 0);
	signal c: std_logic_vector(8 downto 0);
begin
  	g <= x and y;
	p <= x xor y;
		
	c(0) <= cin;

	l: for i in 8 downto 1 generate
		c(i) <= g(i-1) or (p(i-1) and c(i-1));	
	end generate;
	
	sum <= p xor c(7 downto 0);
	cout <= c(8);
end rtl;

