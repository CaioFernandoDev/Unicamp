library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
	generic (
		N : integer := 4
	);
	port (
		a, b : in std_logic_vector(N-1 downto 0);
		r : out std_logic_vector(2*N-1 downto 0);
		clk : in std_logic;
		set : in std_logic
	);
end multiplier;

architecture rtl of multiplier is
	signal multiplier_aux : std_logic_vector(N-1 downto 0);
	signal multiplicand_aux : std_logic_vector(2*N-1 downto 0);
	signal alu_out : std_logic_vector(2*N-1 downto 0);
	signal product : std_logic_vector(2*N-1 downto 0);
	signal multiplier_mode : std_logic_vector(1 downto 0);
	signal multiplicand_mode : std_logic_vector(1 downto 0);
	signal zeros : std_logic_vector(N-1 downto 0);
	
	signal zerosa : std_logic_vector(2*N-1 downto 0);
	signal alu_set : std_logic;
	
	signal not_clk : std_logic;
begin
	zeros <= (others => '0');
	zerosa <= zeros & a;
	not_clk <= not clk;
	
	multiplicand_reg : entity work.shift_register generic map (N => 2*N)
																	port map (clk => not_clk,
																				mode => multiplicand_mode,
																				ser_in  =>'0',
																				par_in => zerosa,
																				par_out => multiplicand_aux);
	multiplier_reg : entity work.shift_register generic map (N => N)
																port map (clk => not_clk,
																			mode => multiplier_mode,
																			ser_in  =>'0',
																			par_in => b,
																			par_out => multiplier_aux);
	alu : entity work.alu generic map (N => 2*N)
									port map (a => product,
												b => multiplicand_aux,
												set => alu_set,
												clk => not_clk,
												data_out => alu_out);
	process
	begin
		wait until clk'event and clk = '1';
		if set = '1' then
			multiplier_mode <= "11";
			multiplicand_mode <= "11";
			product <= (others => '0');
			alu_set <= '0';
		else
			alu_set <= multiplier_aux(0);
			product <= alu_out;
			multiplier_mode <= "10";
			multiplicand_mode <= "01";
		end if;
	end process;
	r <= alu_out;
end rtl;