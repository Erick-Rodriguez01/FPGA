LIBRARY IEEE;
		USE IEEE.STD_LOGIC_1164.ALL;
		USE IEEE.NUMERIC_STD.ALL;
		-----------------------------------------------------------------------------	
		ENTITY Debouncer IS 
		PORT 	 (	Clk   		:	 IN  STD_LOGIC;
					Rst   		:   IN  STD_LOGIC;
					Ena   		:   IN  STD_LOGIC;
					Max_tick		:   OUT STD_LOGIC
					);
		END ENTITY;
		-----------------------------------------------------------------------------	
		ARCHITECTURE rtl OF Debouncer IS
		-----------------------------------------------------------------------------	


			CONSTANT MAX_NUMBER	:	UNSIGNED(22 DOWNTO 0) := "10011000100101101000000";
			CONSTANT MIN_NUMBER  :  UNSIGNED(22 DOWNTO 0) := (OTHERS => '0');
			
			CONSTANT Up          :  STD_LOGIC := '1';
				
			SIGNAL FLAG          :  STD_LOGIC;
			SIGNAL Count_s       :  UNSIGNED(22 DOWNTO 0);
			SIGNAL Count_Next    :  UNSIGNED(22 DOWNTO 0);
			SIGNAL Counter		   :  STD_LOGIC_VECTOR(22 DOWNTO 0);
			
			
		-----------------------------------------------------------------------------	
		BEGIN 

			Count_Next <=   (OTHERS => '0')  WHEN	(FLAG = '1')  ELSE
								 Count_s + 1      WHEN  (Ena  = '1' AND Up   = '1')  ELSE
								 Count_s - 1      WHEN  (Ena  = '1' AND Up   = '0')  ELSE
								 Count_s;
			
			PROCESS (Clk, Rst)
				VARIABLE Temp	:	UNSIGNED(22 DOWNTO 0);
			BEGIN 
				IF (Rst = '1') THEN 
					Temp  := (OTHERS => '0');
					
				ELSIF (RISING_EDGE(Clk)) THEN
					IF (Ena = '1') THEN 
						Temp  := Count_Next;
					END IF;
				END IF;
				Counter <= STD_LOGIC_VECTOR(Temp);
				Count_s <= Temp;
			END PROCESS;
			
			FLAG      <=  '1'  WHEN  Count_s = MAX_NUMBER  ELSE '0';
			Max_tick  <=  FLAG;
			
		END ARCHITECTURE;
		
