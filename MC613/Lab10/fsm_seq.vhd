LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fsm_seq IS
	PORT (
		clock : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		w : IN STD_LOGIC;
		z : OUT STD_LOGIC
	);
END fsm_seq;

ARCHITECTURE rtl OF fsm_seq IS
	TYPE state_type IS (A, B, C, D, E);

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
							state <= B;
						ELSE
							state <= A;
						END IF;

					WHEN B =>
						IF w = '0' THEN
							state <= B;
						ELSE
							state <= C;
						END IF;

					WHEN C =>
						IF w = '0' THEN
							state <= D;
						ELSE
							state <= A;
						END IF;

					WHEN D =>
						IF w = '0' THEN
							state <= B;
						ELSE
							state <= E;
						END IF;

					WHEN E =>
						IF w = '0' THEN
							state <= D;
						ELSE
							state <= A;
						END IF;
				END CASE;
			END IF;
		END IF;
	END PROCESS;
	z <= '1' WHEN state = E ELSE
		'0';
END rtl;