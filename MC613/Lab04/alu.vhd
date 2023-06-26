library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port (
    a, b : in std_logic_vector(3 downto 0);
    F : out std_logic_vector(3 downto 0);
    s0, s1 : in std_logic;
    Z, C, V, N : out std_logic
  );
end alu;

architecture behavioral of alu is
	signal sum_b: std_logic_vector(3 downto 0);
	signal sum_F: std_logic_vector(3 downto 0);
	signal sum_C: std_logic;
	signal sum_V: std_logic;
	signal aux_F: std_logic_vector(3 downto 0);
begin
	sum_b <= not b when (s0 = '1' and s1 = '0') else b;

	adder: entity work.ripple_carry 
				port map(x => a, y => sum_b,
					r => sum_F,
					cin => s0, cout => sum_C,
					overflow => sum_V);

	aux_F <= (a and b) when (s0 = '0' and s1 = '1') else
				(a or b) when (s0 = '1' and s1 = '1') else
				sum_F;

	C <= sum_C when (s1 = '0') else '0';
	V <= sum_V when (s1 = '0') else '0';
	N <= aux_F(3) when (s1 = '0') else '0';
	Z <= '1' when (aux_F = "0000") else '0';
	F <= aux_F;
end behavioral;
