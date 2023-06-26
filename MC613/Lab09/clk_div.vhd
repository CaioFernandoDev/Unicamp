LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY clk_div IS
	PORT (
		clk : IN STD_LOGIC;
		clk_hz : OUT STD_LOGIC
	);
END clk_div;

ARCHITECTURE behavioral OF clk_div IS
	SIGNAL Count : INTEGER RANGE 0 TO 49999999;
BEGIN
	PROCESS (clk, count)
	BEGIN

		IF (clk'event AND clk = '1') THEN
			IF (count = 49999999) THEN
				count <= 0;
			ELSE
				count <= count + 1;
			END IF;
		END IF;

		IF count = 49999999 THEN
			clk_hz <= '1';
		ELSE
			clk_hz <= '0';
		END IF;

	END PROCESS;
END behavioral;