library ieee;
use ieee.std_logic_1164.all;

entity alu is
  generic (
    N : integer := 8
  );
  port (
    a, b : in std_logic_vector(N-1 downto 0);
	 set : in std_logic;
	 clk : in std_logic;
    data_out : out std_logic_vector(N-1 downto 0)
  );
end alu;

architecture rtl of alu is
	signal sum : std_logic_vector(N-1 downto 0);
begin
	adder: entity work.ripple_carry generic map (N => N)
												port map (x => a,
													y => b,
													r => sum,
													cin => '0');
	process
	begin
		wait until clk'event and clk = '1';	
			if set = '1' then
				data_out <= sum;
			else
				data_out <= a;
			end if;
	end process;
end rtl;