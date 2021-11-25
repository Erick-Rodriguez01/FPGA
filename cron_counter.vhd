LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-------------------------------------------
ENTITY cron_counter IS
GENERIC ( N : INTEGER := 4
);
PORT ( clk : IN STD_LOGIC;
rst : IN STD_LOGIC;
ena : IN STD_LOGIC;
max_count : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
syn_clr : IN STD_LOGIC;
max_tick : OUT STD_LOGIC;
counter : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));



END ENTITY;
-------------------------------------------
ARCHITECTURE rtl OF cron_counter IS
CONSTANT ONES : UNSIGNED(N-1 DOWNTO 0) := (OTHERS => '1');
CONSTANT ZEROS : UNSIGNED(N-1 DOWNTO 0) := (OTHERS => '0');
--SIGNAL count_s : INTEGER RANGE 0 TO (2**N-1);



SIGNAL count_s : UNSIGNED(N-1 DOWNTO 0);
SIGNAL count_next : UNSIGNED(N-1 DOWNTO 0);



BEGIN
--NEXT STAGE LOGIC
count_next <= (OTHERS => '0') WHEN (syn_clr ='1') OR (count_s = unsigned(max_count)) ELSE
count_s + 1 WHEN ena='1' ELSE
count_s;

PROCESS(clk, rst)
VARIABLE temp : UNSIGNED(N-1 DOWNTO 0);
BEGIN
IF(rst='1') THEN
temp := (OTHERS => '0');
ELSE IF (rising_edge(clk)) THEN
if (ena= '1') THEN
temp := count_next;
END IF;
END IF;
END IF;
counter <= STD_LOGIC_VECTOR(temp);
count_s <= temp;

END PROCESS;



-- OUTPUT LOGIC
max_tick <= '1' WHEN unsigned(max_count)=count_s ELSE '0';

END ARCHITECTURE;