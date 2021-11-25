------------------------------------------
-- CONVERSOR DE BITS A 7 SEGMENTOS
------------------------------------------
library IEEE;
USE ieee.std_logic_1164.all;
-------------------------------------------
ENTITY bin_toseg IS
PORT( swch : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));

END ENTITY bin_toseg;
-------------------------------------------
ARCHITECTURE structural OF bin_toseg IS
BEGIN
WITH swch SELECT
		seg <=  "1000000" WHEN "0000",  -- 0E
				  "1111001" WHEN "0001",  -- 1
				  "0100100" WHEN "0010",  -- 2
				  "0110000" WHEN "0011",  -- 3
				  "0011001" WHEN "0100",  -- 4
				  "0010010" WHEN "0101",  -- 5
				  "0000010" WHEN "0110",  -- 6
				  "1111000" WHEN "0111",  -- 7
				  "0000000" WHEN "1000",  -- 8
				  "0010000" WHEN "1001",  -- 9
				  "0000010" WHEN "1010",  -- G
				  "0001100" WHEN "1011",  -- P
				  "0111111" WHEN "1100",  -- -
				  "0000110" WHEN OTHERS;  -- E
END structural;