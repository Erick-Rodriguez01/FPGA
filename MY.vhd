LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


package MY is 
procedure SQ (SIGNAL xcur, ycur,xpos, ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR (3 DOWNTO 0); SIGNAL DRAW: OUT STD_LOGIC);
END MY; 

pacKage BODY MY IS 
procedure SQ (SIGNAL xcur, ycur,xpos, ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR (3 DOWNTO 0); SIGNAL DRAW: OUT STD_LOGIC)IS 
BEGIN 
IF (xcur >xpos AND xcur <(xpos+35)AND ycur > (ypos)AND ycur <(ypos +45)) THEN 

	RGB<= "1111"; 
	DRAW <= '1'; 
	ELSE 
	DRAW <= '0';  

END IF; 
END SQ; 
END MY; 






