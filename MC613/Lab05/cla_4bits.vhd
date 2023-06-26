-- brief : lab05 - question 2

library ieee;
use ieee.std_logic_1164.all;

entity cla_4bits is
  port(
    x    : in  std_logic_vector(3 downto 0);
    y    : in  std_logic_vector(3 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(3 downto 0);
    cout : out std_logic
  );
end cla_4bits;

architecture rtl of cla_4bits is
	signal g: std_logic_vector(3 downto 0);
	signal p: std_logic_vector(3 downto 0);
	signal c: std_logic_vector(4 downto 0);
begin
  	g <= x and y;
	p <= x xor y;
		
	c(0) <= cin;

	l: for i in 4 downto 1 generate
		c(i) <= g(i-1) or (p(i-1) and c(i-1));	
	end generate;
	
	sum <= p xor c(3 downto 0);
	cout <= c(4);
end rtl;

