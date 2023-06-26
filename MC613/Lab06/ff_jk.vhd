library ieee;
use ieee.std_logic_1164.all;

entity ff_jk is
  port (
    Clk : in std_logic;
    J : in std_logic;
    K : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_jk;

architecture rtl of ff_jk is
begin
	PROCESS (Clk, Preset, Clear)  
	VARIABLE temp: std_logic;
	VARIABLE jk: std_logic_vector (2 downto 1);
	BEGIN
		jk := J & K;
		IF (Clk'EVENT AND Clk='1') then                        
			CASE (jk) IS
				WHEN "11" => temp := NOT temp;
				WHEN "10" => temp := '1';
				WHEN "01" => temp := '0';
				WHEN others => temp := temp; 
			END CASE;
		END IF;
		
		IF Clk'EVENT AND Clk = '1' AND Preset = '1' THEN 
			temp := '1' ;
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Clear = '1' THEN 
			temp := '0' ;
		END IF ;
		
		Q <= temp;
		Q_n <= NOT temp;	
	
	END PROCESS;
end rtl;
