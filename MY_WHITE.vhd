LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


package MY_WHITE is 
procedure SQ_WHITE (SIGNAL xcur, ycur,xpos, ypos: IN INTEGER; SIGNAL DRAW: OUT STD_LOGIC);
END MY_WHITE; 

pacKage BODY MY_WHITE IS 
procedure SQ_WHITE(SIGNAL xcur, ycur,xpos, ypos: IN INTEGER;  SIGNAL DRAW: OUT STD_LOGIC)IS 
BEGIN 
IF (xcur >xpos AND xcur <(xpos+50)AND ycur > (ypos)AND ycur <(ypos +80)) THEN  
	DRAW <= '1'; 
	ELSE 
	DRAW <= '0';  

END IF; 
END SQ_WHITE; 
END MY_WHITE; 