Library ieee;
USE ieee.std_logic_1164.all;

Entity REGISTRO_B IS
	PORT( clk : IN STD_LOGIC;
			rst : IN STD_LOGIC;
			ena : IN STD_LOGIC;
			data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ENTITY;
----------------------------------
ARCHITECTURE structural of REGISTRO_B IS

BEGIN
REG: FOR i IN 0 TO 3 GENERATE
DFF: ENTITY work.my_dff
PORT MAP ( clk =>clk,
		  rst =>rst,
		  ena =>ena,
		  d =>data(i),
		  q =>q(i));
END GENERATE;



END ARCHITECTURE;