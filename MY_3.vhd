LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


package MY_3 is 
procedure SQ_3 (SIGNAL xcur, ycur,xpos, ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR (3 DOWNTO 0); SIGNAL DRAW: OUT STD_LOGIC);
END MY_3; 

pacKage BODY MY_3 IS 
procedure SQ_3(SIGNAL xcur, ycur,xpos, ypos: IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR (3 DOWNTO 0); SIGNAL DRAW: OUT STD_LOGIC)IS 
BEGIN 
IF ((xcur >1026 AND xcur <(1026+7)AND ycur > (42)AND ycur <(42 +100)) or (xcur >1026 AND xcur <(1026+7)AND ycur > (152)AND ycur <(152 +100)) 
or  (xcur >1026 AND xcur <(1026+7)AND ycur > (262)AND ycur <(262 +100)) or (xcur >1026 AND xcur <(1026+7)AND ycur > (372)AND ycur <(372 +100)) or 
(xcur >1026 AND xcur <(1026+7)AND ycur > (482)AND ycur <(482 +100)) or (xcur >1026 AND xcur <(1026+7)AND ycur > (592)AND ycur <(592 +100)) or 
(xcur >1026 AND xcur <(1026+7)AND ycur > (702)AND ycur <(702 +100)) or (xcur >1026 AND xcur <(1026+7)AND ycur > (812)AND ycur <(812+100)) or 
(xcur >1026 AND xcur <(1026+7)AND ycur > (922)AND ycur <(922 +100)) or (xcur >1026 AND xcur <(1026+7)AND ycur > (1032)AND ycur <(1032 +100))) THEN 

	RGB<= "1111"; 
	DRAW <= '1'; 
	ELSE 
	DRAW <= '0';  

END IF; 
END SQ_3; 
END MY_3; 