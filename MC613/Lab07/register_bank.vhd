library ieee;
use ieee.std_logic_1164.all;

entity register_bank is
  port (
    clk : in std_logic;
    data_in : in std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0);
    reg_rd : in std_logic_vector(2 downto 0);
    reg_wr : in std_logic_vector(2 downto 0);
    we : in std_logic;
    clear : in std_logic
  );
end register_bank;

architecture structural of register_bank is
SIGNAL d2r: std_logic_vector(0 to 7);
SIGNAL r2d: std_logic_vector(0 to 7);
SIGNAL data_out_aux: std_logic_vector(31 downto 0);
SIGNAL load_aux: std_logic_vector(0 to 7);
begin

	dec3x8_1: entity work.dec3_to_8
		port map(
			w => reg_wr,
			y => d2r
		);
	dec3x8_2: entity work.dec3_to_8
		port map(
			w => reg_rd,
			y => r2d
		);
	 
	 l: for i in 0 to 7 generate
		load_aux(i) <= d2r(i) and we;
		reg: entity work.reg
				generic map (N => 4)
				port map(
					clk => clk,
					data_in => data_in,
					data_out => data_out_aux(i * 4 + 3 downto i * 4),
					load => load_aux(i),
					clear => clear
				);
	  
		zbuffer: entity work.zbuffer
						port map(
							x => data_out_aux(i * 4 + 3 downto i * 4),
							e => r2d(i),
							f => data_out
						);
		end generate;

end structural;
