LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm_table IS
	PORT (
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		w : IN STD_LOGIC;
		z : OUT STD_LOGIC
	);
END fsm_table;

ARCHITECTURE rtl OF fsm_table IS
	TYPE state_type IS (A, B, C, D);

	SIGNAL state : state_type;
BEGIN
	PROCESS (clock)
	BEGIN
		IF (clock'event AND clock = '1') THEN
			-- subida do clock
			IF reset = '1' THEN
				state <= A;
			ELSE
				-- logica de mudanca de estado
				CASE state IS
					WHEN A =>
						IF w = '0' THEN
							state <= C;
						ELSE
							state <= B;
						END IF;

					WHEN B =>
						IF w = '0' THEN
							state <= D;
						ELSE
							state <= C;
						END IF;

					WHEN C =>
						IF w = '0' THEN
							state <= B;
						ELSE
							state <= C;
						END IF;

					WHEN D =>
						IF w = '0' THEN
							state <= A;
						ELSE
							state <= C;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	PROCESS (w)
	BEGIN
		CASE state IS
			WHEN A =>
				IF w = '0' THEN
					z <= '1';
				ELSE
					z <= '1';
				END IF;

			WHEN B =>
				IF w = '0' THEN
					z <= '1';
				ELSE
					z <= '0';
				END IF;

			WHEN C =>
				IF w = '0' THEN
					z <= '0';
				ELSE
					z <= '0';
				END IF;

			WHEN D =>
				IF w = '0' THEN
					z <= '0';
				ELSE
					z <= '1';
				END IF;
		END CASE;
	END PROCESS;
END rtl;