LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY clock IS
	PORT (
		clk : IN STD_LOGIC;
		decimal : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		unity : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		set_hour : IN STD_LOGIC;
		set_minute : IN STD_LOGIC;
		set_second : IN STD_LOGIC;
		hour_dec, hour_un : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		min_dec, min_un : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		sec_dec, sec_un : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END clock;

ARCHITECTURE rtl OF clock IS
	SIGNAL clk_hz : STD_LOGIC;
	SIGNAL hour_dec_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL hour_un_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL min_dec_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL min_un_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sec_dec_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL sec_un_sig : STD_LOGIC_VECTOR(3 DOWNTO 0);

	COMPONENT clk_div IS
		PORT (
			clk : IN STD_LOGIC;
			clk_hz : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT bin2dec IS
		PORT (
			bin : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			dec : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	clock_divider : clk_div PORT MAP(clk, clk_hz);
	hour2dec_dec : bin2dec PORT MAP(hour_dec_sig, hour_dec);
	hour2dec_un : bin2dec PORT MAP(hour_un_sig, hour_un);
	min2dec_dec : bin2dec PORT MAP(min_dec_sig, min_dec);
	min2dec_un : bin2dec PORT MAP(min_un_sig, min_un);
	sec2dec_dec : bin2dec PORT MAP(sec_dec_sig, sec_dec);
	sec2dec_un : bin2dec PORT MAP(sec_un_sig, sec_un);

	PROCESS (clk)
		VARIABLE hour_dec_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		VARIABLE hour_un_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		VARIABLE min_dec_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		VARIABLE min_un_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		VARIABLE sec_dec_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
		VARIABLE sec_un_aux : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	BEGIN
		IF (clk'event AND clk = '1') THEN
			-- SET
			IF (set_hour = '1') THEN
				IF (decimal = "0000" OR decimal = "0001") THEN
					IF (unity <= "1001") THEN
						hour_dec_aux := decimal;
						hour_un_aux := unity;
					END IF;
				ELSIF (decimal = "0010") THEN
					IF (unity <= "0011") THEN
						hour_dec_aux := decimal;
						hour_un_aux := unity;
					END IF;
				END IF;
			END IF;

			IF (set_minute = '1') THEN
				IF (decimal <= "0101") THEN
					IF (unity <= "1001") THEN
						min_dec_aux := decimal;
						min_un_aux := unity;
					END IF;
				END IF;
			END IF;

			IF (set_second = '1') THEN
				IF (decimal <= "0101") THEN
					IF (unity <= "1001") THEN
						sec_dec_aux := decimal;
						sec_un_aux := unity;
					END IF;
				END IF;
			END IF;

			-- CLOCK
			IF (clk_hz = '1') THEN
				-- SOMA SEGUNDO 
				IF (sec_un_aux <= "1000") THEN
					sec_un_aux := sec_un_aux + 1;
				ELSE
					sec_un_aux := "0000";
					IF (sec_dec_aux <= "0100") THEN
						sec_dec_aux := sec_dec_aux + 1;
					ELSE
						sec_dec_aux := "0000";
						-- SOMA MINUTO
						IF (min_un_aux <= "1000") THEN
							min_un_aux := min_un_aux + 1;
						ELSE
							min_un_aux := "0000";
							IF (min_dec_aux <= "0100") THEN
								min_dec_aux := min_dec_aux + 1;
							ELSE
								min_dec_aux := "0000";
								-- SOMA HORA
								IF (hour_un_aux <= "1000") THEN
									IF (hour_dec_aux = "0010" AND hour_un_aux = "0011") THEN
										hour_dec_aux := "0000";
										hour_un_aux := "0000";
									ELSE
										hour_un_aux := hour_un_aux + 1;
									END IF;
								ELSE
									hour_un_aux := "0000";
									hour_dec_aux := hour_dec_aux + 1;
								END IF;
							END IF;
						END IF;
					END IF;
				END IF;
			END IF;
		END IF;
		hour_dec_sig <= hour_dec_aux;
		hour_un_sig <= hour_un_aux;
		min_dec_sig <= min_dec_aux;
		min_un_sig <= min_un_aux;
		sec_dec_sig <= sec_dec_aux;
		sec_un_sig <= sec_un_aux;
	END PROCESS;
END rtl;