LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY clock_board IS
  PORT (
    CLOCK_50 : IN STD_LOGIC;
    SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 1);
    HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
  );
END clock_board;

ARCHITECTURE rtl OF clock_board IS
  COMPONENT clock IS
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
  END COMPONENT;
BEGIN

  clock_inst : clock PORT MAP(
    clk => CLOCK_50,
    decimal => SW(7 DOWNTO 4),
    unity => SW(3 DOWNTO 0),
    set_hour => NOT KEY(3),
    set_minute => NOT KEY(2),
    set_second => NOT KEY(1),
    hour_dec => HEX5,
    hour_un => HEX4,
    min_dec => HEX3,
    min_un => HEX2,
    sec_dec => HEX1,
    sec_un => HEX0
  );

END rtl;