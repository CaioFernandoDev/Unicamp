library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry is
  generic (
    N : integer := 4
  );
  port (
    x,y : in std_logic_vector(N-1 downto 0);
    r : out std_logic_vector(N-1 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    overflow : out std_logic
  );
end ripple_carry;

architecture rtl of ripple_carry is
	component full_adder 
		port (
		 x, y : in std_logic;
		 r : out std_logic;
		 cin : in std_logic;
		 cout : out std_logic
	  );
	end component;
	signal t : std_logic_vector(N downto 0);
begin
	t(0) <= cin;
	FA : for i in 0 to N-1 generate
		loop_i : full_adder port map(x(i), y(i), r(i), t(i), t(i+1));
	end generate;
	
	overflow <= t(N) xor t(N-1);
	cout <= t(N);
end rtl;
