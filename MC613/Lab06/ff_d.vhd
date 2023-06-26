library ieee;
use ieee.std_logic_1164.all;

entity ff_d is
  port (
    Clk : in std_logic;
    D : in std_logic;
    Q : out std_logic;
    Q_n : out std_logic;
    Preset : in std_logic;
    Clear : in std_logic
  );
end ff_d;

architecture rtl of ff_d is
begin
	PROCESS (Clk, Preset, Clear) 
	VARIABLE temp: std_logic;
	
	BEGIN 
		IF Clk'EVENT AND Clk = '1' THEN 
			temp := D ;		
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Preset = '1' THEN 
			temp := '1' ;
		END IF ;
		
		IF Clk'EVENT AND Clk = '1' AND Clear = '1' THEN 
			temp := '0' ;
		END IF ;
			
		Q <= temp;
		Q_n <= NOT temp;	
		
	END PROCESS ;
end rtl;
