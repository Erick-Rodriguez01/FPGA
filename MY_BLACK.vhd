LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


package MY_BLACK is 
procedure SQ_BLACK (SIGNAL xcur, ycur,xpos, ypos,X_TAM,Y_TAM: IN INTEGER; SIGNAL DRAW: OUT STD_LOGIC);
END MY_BLACK; 

pacKage BODY MY_BLACK IS 
procedure SQ_BLACK(SIGNAL xcur, ycur,xpos, ypos,X_TAM,Y_TAM: IN INTEGER;  SIGNAL DRAW: OUT STD_LOGIC)IS 
BEGIN 
IF (xcur >xpos AND xcur <(xpos+X_TAM)AND ycur > (ypos)AND ycur <(ypos +Y_TAM)) THEN  
	DRAW <= '1'; 
	ELSE 
	DRAW <= '0';  

END IF; 
END SQ_BLACK; 
END MY_BLACK; 