LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm_diag IS
	PORT (
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		w : IN STD_LOGIC;
		z : OUT STD_LOGIC
	);
END fsm_diag;

ARCHITECTURE rtl OF fsm_diag IS
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
							state <= A;
						ELSE
							state <= B;
						END IF;

					WHEN B =>
						IF w = '0' THEN
							state <= C;
						ELSE
							state <= B;
						END IF;

					WHEN C =>
						IF w = '0' THEN
							state <= C;
						ELSE
							state <= D;
						END IF;

					WHEN D =>
						IF w = '0' THEN
							state <= A;
						ELSE
							state <= D;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
	z <= '1' WHEN state = B ELSE
		'0';
END rtl;