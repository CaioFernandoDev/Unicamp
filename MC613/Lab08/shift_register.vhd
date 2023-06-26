library ieee;
use ieee.std_logic_1164.all;

entity shift_register is
generic (N : integer := 6);
port(
    clk     : in  std_logic;
    mode    : in  std_logic_vector(1 downto 0);
    ser_in  : in  std_logic;
    par_in  : in  std_logic_vector((N - 1) downto 0);
    par_out : out std_logic_vector((N - 1) downto 0)
  );
end shift_register;

architecture rtl of shift_register is
begin
  process
  	  variable out_aux: std_logic_vector((N - 1) downto 0);
  begin
	wait until clk'event and clk = '1';

    if mode = "01" then
      for i in N-1 downto 1 loop
        out_aux(i) := out_aux(i-1);
      end loop;
      out_aux(0) := ser_in;
        
    elsif mode = "10" then
      for i in 0 to N-2 loop
        out_aux(i) := out_aux(i+1);
      end loop;
      out_aux(N-1) := ser_in;
      
    elsif mode = "11" then
      out_aux := par_in;
    end if;
	 par_out <= out_aux;
  end process;
end rtl;
