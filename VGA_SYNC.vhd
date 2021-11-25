LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE WORK.MY.ALL; 
USE WORK.MY_2.ALL; 
USE WORK.MY_3.ALL; 
USE WORK.MY_WHITE.ALL; 
USE WORK.MY_BLACK.ALL; 
--VGA 1280x1024 
-- 42 limite superior y 
-- 1021 limite inferior Y 
--------------------------------------------------------
ENTITY VGA_SYNC IS
    PORT(   
			clk        : IN  STD_LOGIC;
		   buttons	  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			sel_XB     : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
			sel_YB     : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
--			start		  : IN STD_LOGIC;
			Hsync      : OUT STD_LOGIC;
			Vsync 	  : OUT STD_LOGIC;
			R   	     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			G   		  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Amarillo xd 
			B          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			SQ_Y7_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x7_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y1_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x1_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y2_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x2_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
			Techo      : OUT STD_LOGIC; 
			Piso       : OUT STD_LOGIC;
			vel        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			GOL_IZQ	  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			GOL_DER	  : IN STD_LOGIC_VECTOR(3 DOWNTO 0)	); 
			
END ENTITY;
--------------------------------------------------------
ARCHITECTURE GATELEVEL OF VGA_SYNC IS

SIGNAL RGB1:  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL RGB7:  STD_LOGIC_VECTOR(3 DOWNTO 0); 
SIGNAL RGB2, RGB3:  STD_LOGIC_VECTOR(3 DOWNTO 0); 

SIGNAL DRAW1: STD_LOGIC := '1'; 
SIGNAL DRAW7: STD_LOGIC := '1'; 
SIGNAL DRAW2,DRAW3: STD_LOGIC := '1'; 
SIGNAL HPOS: INTEGER RANGE 0 TO 1688:=0;
SIGNAL VPOS: INTEGER RANGE 0 TO 1066:=0;
SIGNAL SQ_X1: INTEGER RANGE 0 TO 1688:=1640; 
SIGNAL SQ_Y1: INTEGER RANGE 0 TO 1688:=400; 
SIGNAL SQ_X7: INTEGER RANGE 0 TO 1688:=420; 
SIGNAL SQ_Y7: INTEGER RANGE 0 TO 1688:=400; 
-- Bola 
SIGNAL SQ_X2: INTEGER RANGE 0 TO 1688:=1009; 
SIGNAL SQ_Y2: INTEGER RANGE 0 TO 1688:=500; 
SIGNAL TOQUES: INTEGER RANGE 0 TO 20:=0;
SIGNAL X: INTEGER RANGE 0 TO 20:=0;
SIGNAL SQ_X3: INTEGER RANGE 0 TO 1688:=420; 
SIGNAL SQ_Y3: INTEGER RANGE 0 TO 1688:=400;
--WHite
SIGNAL SQ_WX1: INTEGER RANGE 0 TO 1688:=764; 
SIGNAL SQ_WY1: INTEGER RANGE 0 TO 1688:=50;
SIGNAL SQ_WX2: INTEGER RANGE 0 TO 1688:=1232; 
SIGNAL DRAWW1,DRAWW2: STD_LOGIC := '1'; 

--BLACK
SIGNAL SQ_BX1: INTEGER RANGE 0 TO 1688:=774; 
SIGNAL SQ_BY1: INTEGER RANGE 0 TO 1688:=60;
SIGNAL SQ_BX2: INTEGER RANGE 0 TO 1688:=1242; 
SIGNAL SQ_BY2: INTEGER RANGE 0 TO 1688:=60;
SIGNAL SQ_BX3: INTEGER RANGE 0 TO 1688:=774; 
SIGNAL SQ_BY3: INTEGER RANGE 0 TO 1688:=60;
SIGNAL SQ_BX4: INTEGER RANGE 0 TO 1688:=1242; 
SIGNAL SQ_BY4: INTEGER RANGE 0 TO 1688:=60; 
SIGNAL DRAWB1,DRAWB2,DRAWB3,DRAWB4: STD_LOGIC := '1'; 
SIGNAL X_TAM_1: INTEGER RANGE 0 TO 1688:=30;
SIGNAL Y_TAM_1: INTEGER RANGE 0 TO 1688:=60;
SIGNAL X_TAM_2: INTEGER RANGE 0 TO 1688:=40;
SIGNAL Y_TAM_2:INTEGER RANGE 0 TO 1688:=80;
SIGNAL X_TAM_3: INTEGER RANGE 0 TO 1688:=30;
SIGNAL Y_TAM_3 :INTEGER RANGE 0 TO 1688:=60;
SIGNAL X_TAM_4 :INTEGER RANGE 0 TO 1688:=40;
SIGNAL Y_TAM_4 :INTEGER RANGE 0 TO 1688:=80;

BEGIN

--PALETAS, PELOTAS Y MEDIO --------------------

SQ_2 (HPOS, VPOS, SQ_X7,SQ_Y7,RGB7,DRAW7); 
SQ_2 (HPOS, VPOS, SQ_X1,SQ_Y1,RGB1,DRAW1);
SQ (HPOS, VPOS, SQ_X2,SQ_Y2,RGB2,DRAW2);
SQ_3 (HPOS, VPOS,SQ_X3, SQ_Y3 ,RGB3,DRAW3);

------------------------------------------------

-----SELECTOR GOL IZQUIERDA 1,2 -------
				--1 CUADRADO ABAJO--
X_TAM_1 <= 30 WHEN GOL_DER="0000" OR GOL_DER="1000" OR GOL_DER="0110" ELSE --0-8-6
			  40 WHEN GOL_DER="0001" ELSE--1
			  40 WHEN GOL_DER="0010" ELSE--2
			  40;
			  
Y_TAM_1 <= 60 WHEN GOL_DER="0000" ELSE --0
			  80 WHEN GOL_DER="0001" ELSE --1
			  25 WHEN GOL_DER="0010" OR GOL_DER="0011" OR GOL_DER="0101" OR GOL_DER="0110" OR GOL_DER="1000" OR GOL_DER="1001" ELSE --2-3-5-6-8-9
			  40 WHEN GOL_DER="0100" ELSE --4
			  70;
			  
SQ_BX1 <= 764 WHEN GOL_DER="0001" OR GOL_DER="0011" OR GOL_DER="0100" OR GOL_DER="0101" OR GOL_DER="0111" OR GOL_DER="1001" ELSE--1-3-4-5-7-9
			 774;--0-2-6-8
			  
SQ_BY1 <= 50 WHEN GOL_DER="0001" ELSE--1
			 60 WHEN GOL_DER="0000" OR GOL_DER="0111" ELSE --0-7
			 90 WHEN GOL_DER="0100" ELSE--4
			 95;--2-5-6-3-8-9

				--2 CUADRADO ARRIBA--
X_TAM_2 <= 30 WHEN GOL_DER="0000" OR GOL_DER="1000" OR GOL_DER="0100" OR GOL_DER="1001" ELSE --0-8-4-9
			  40 WHEN GOL_DER="0001" ELSE--1
			  40 WHEN GOL_DER="0010" ELSE--2-3-5-6-7
			  40;
			  
Y_TAM_2 <= 60 WHEN GOL_DER="0000" ELSE --0
			  80 WHEN GOL_DER="0001" ELSE --1
			  30 WHEN GOL_DER="0100" ELSE --4
			  70 WHEN GOL_DER="0111" ELSE --7
			  25;--2-3-5-6-8-9


SQ_BX2 <= 764 WHEN  GOL_DER="0001" OR GOL_DER="0010" OR GOL_DER="0011" OR GOL_DER="0111" ELSE --1-2-3-7
		    774; --0-4-5-6-8-9
			 
SQ_BY2 <= 60 WHEN GOL_DER="0000" ELSE --0
			 80 WHEN GOL_DER="0001" ELSE --1
			 70 WHEN GOL_DER="0111" ELSE --7
			 50 WHEN GOL_DER="0100" ELSE--4
			 60 WHEN GOL_DER="1000" ELSE --8
			 60;--2-3-5-6-9
			 

----SELECTOR GOL DERECHA 3,4 -------
				--3 CUADRADO ABAJO--
X_TAM_3 <= 30 WHEN GOL_IZQ="0000" OR GOL_IZQ="1000" OR GOL_IZQ="0110" ELSE --0-8-6
			  40 WHEN GOL_IZQ="0001" ELSE--1
			  40 WHEN GOL_IZQ="0010" ELSE--2
			  40;
			  
Y_TAM_3 <= 60 WHEN GOL_IZQ="0000" ELSE --0
			  80 WHEN GOL_IZQ="0001" ELSE --1
			  25 WHEN GOL_IZQ="0010" OR GOL_IZQ="0011" OR GOL_IZQ="0101" OR GOL_IZQ="0110" OR GOL_IZQ="1000" OR GOL_IZQ="1001" ELSE --2-3-5-6-8-9
			  40 WHEN GOL_IZQ="0100" ELSE --4
			  70;
			  
SQ_BX3 <= 1232 WHEN GOL_IZQ="0001" OR GOL_IZQ="0011" OR GOL_IZQ="0100" OR GOL_IZQ="0101" OR GOL_IZQ="0111" OR GOL_IZQ="1001" ELSE--1-3-4-5-7-9
			 1242;--0-2-6-8
		  
SQ_BY3 <= 50 WHEN GOL_IZQ="0001" ELSE--1
			 60 WHEN GOL_IZQ="0000" OR GOL_IZQ="0111" ELSE --0-7
			 90 WHEN GOL_IZQ="0100" ELSE--4
			 95;--2-5-6-3-8-9

				--4 CUADRADO ARRIBA--
X_TAM_4 <= 30 WHEN GOL_IZQ="0000" OR GOL_IZQ="1000" OR GOL_IZQ="0100" OR GOL_IZQ="1001" ELSE --0-8-4-9
			  40 WHEN GOL_IZQ="0001" ELSE--1
			  40 WHEN GOL_IZQ="0010" ELSE--2-3-5-6-7
			  40;
			  
Y_TAM_4 <= 60 WHEN GOL_IZQ="0000" ELSE --0
			  80 WHEN GOL_IZQ="0001" ELSE --1
			  30 WHEN GOL_IZQ="0100" ELSE --4
			  70 WHEN GOL_IZQ="0111" ELSE --7
			  25; --2-3-5-6-8-9
			  
SQ_BX4<= 1232 WHEN  GOL_IZQ="0001" OR GOL_IZQ="0010" OR GOL_IZQ="0011" OR GOL_IZQ="0111" ELSE --1-2-3-7
		    1242; --0-4-5-6-8-9	
			  
SQ_BY4 <= 60 WHEN GOL_IZQ="0000" ELSE --0
			 80 WHEN GOL_IZQ="0001" ELSE --1
			 70 WHEN GOL_IZQ="0111" ELSE --7
			 50 WHEN GOL_IZQ="0100" ELSE --4
			 60 WHEN GOL_IZQ="1000" ELSE --8
			 60;--2-3-5-6-9
--------------------BLANCOS----------------
SQ_WHITE (HPOS, VPOS,SQ_WX1, SQ_WY1 ,DRAWW1); --BLANCO IZQUIERDA
SQ_WHITE (HPOS, VPOS,SQ_WX2, SQ_WY1 ,DRAWW2); --BLANCO DERECHA
--------------------------------------------
-----------------NEGROS-------------------------
SQ_BLACK (HPOS, VPOS,SQ_BX1, SQ_BY1,X_TAM_1,Y_TAM_1,DRAWB1);--CUADRO NEGRO IZQUIERDA
SQ_BLACK (HPOS, VPOS,SQ_BX2, SQ_BY2,X_TAM_2,Y_TAM_2,DRAWB2);--2 CUADRO NEGRO IZQUIERDA
SQ_BLACK (HPOS, VPOS,SQ_BX3, SQ_BY3,X_TAM_3,Y_TAM_3 ,DRAWB3);-- CUADRO NEGRO DERECHA
SQ_BLACK (HPOS, VPOS,SQ_BX4, SQ_BY4,X_TAM_4,Y_TAM_4 ,DRAWB4);--2 CUADRO NEGRO DERECHA


PROCESS(clk, SQ_Y7, SQ_x7,SQ_Y1,SQ_x1,SQ_y2,SQ_x2, SEL_XB, SEL_YB)

BEGIN

TOQUES<= to_integer(unsigned(vel));


IF (rising_edge(clk))THEN --Sí hay un pulso de subida.


IF (DRAW1='1')  THEN 
	R<= "1111"; 
	G<= "1111" ;
	B<= "1111"; 
	
	ELSIF(DRAW7='1')  THEN 
	R<= "1111"; 
	G<= "1111" ;
	B<= "1111"; 
	
	ELSIF(DRAW2='1')  THEN 
	R<= "1100"; 
	G<= "1110" ;
	B<= "1010"; 
	
	ELSIF(DRAW3='1')  THEN 
	R<= "1111"; 
	G<= "1110" ;
	B<= "1111"; 
	
	ELSIF(DRAWB2='1' OR DRAWB1='1')  THEN 
	R<= "0000"; 
	G<= "0000" ;
	B<= "0000"; 
	
	ELSIF(DRAWB3='1' OR DRAWB4='1')  THEN 
	R<= "0000"; 
	G<= "0000" ;
	B<= "0000"; 
	
	ELSIF(DRAWW2='1' OR DRAWW1='1')  THEN 
	R<= "1111"; 
	G<= "1111" ;
	B<= "1111"; 
	

	
	ELSE 
	R<="0000";
	G<="0000";
	B<="0000";
END IF; 

	

	IF (HPOS<1688) THEN		-- Sí no ha recorrido todas las zonas visibles y no visibles
	HPOS<=HPOS+1;				-- Cambie de posición.
	ELSE 
	HPOS<=0;
		IF(VPOS<1066) THEN
			VPOS<=VPOS+1;
			ELSE
			VPOS<=0; 
						

							
								
					    IF(buttons(0)='0' AND (SQ_Y7 < 822 ))THEN
						  SQ_Y7<=SQ_Y7+5;
						  					
						  END IF;
                   IF(buttons(1)='0' AND(SQ_Y7 > 42 ))THEN
						  SQ_Y7<=SQ_Y7-5;
						  
						 END IF;
						  IF(buttons(2)='0' AND(SQ_Y1 > 42 ))THEN
						  SQ_Y1<=SQ_Y1-5;
						 END IF;
						 
						 IF(buttons(3)='0' AND(SQ_Y1 < 822))THEN
						  SQ_Y1<=SQ_Y1+5;
						 END IF;
						
						 -- Bola en x 	 
						 IF (SEL_XB = "01") THEN 
							SQ_x2 <= (SQ_X2 + (TOQUES +3)) ; -- TOQUES; 
						 ELSIF ( SEL_XB = "10") THEN 
						   SQ_x2 <=  (SQ_X2 -  (TOQUES+3)); --TOQUES;
						 ELSIF (SEL_XB="11") THEN
						  SQ_X2<= 1010;
						ELSE 
							SQ_X2 <= SQ_X2;	
						END IF; 
						
						-- Bola en y 
						
						IF ((SEL_YB = "01") AND (SQ_Y2 < 975)) THEN 
							SQ_Y2 <= (SQ_Y2 +(TOQUES+3));  --TOQUES; 
						ELSIF ((SEL_YB = "01") AND (SQ_Y2 >976)) THEN
							PISO<='1';
						ELSIF ((SEL_YB = "10") AND (SQ_Y2 >42))THEN 
						   SQ_Y2 <= (SQ_Y2 - (TOQUES+3)); 
						ELSIF ((SEL_YB = "10") AND (SQ_Y2 <= 42))THEN 
							TECHO<='1';
						ELSIF ((SEL_YB = "11") )THEN 
							SQ_Y2<= 530;
					
						ELSE
						   SQ_Y2 <= SQ_Y2;
                      PISO<='0';
							 TECHO<='0';
							
						END IF; 
							
	
		END IF;
	END IF;
	IF (HPOS>48 AND HPOS<160)THEN
		HSYNC<='0';
		ELSE
		HSYNC<='1';
	END IF;
	IF (VPOS>0 AND VPOS<4)THEN
		VSYNC<='0';
		ELSE
		VSYNC<='1';
	END IF;
	IF ((HPOS>0 AND HPOS<408) OR (VPOS>0 AND VPOS<42)) THEN
		R<="0000";
		G<="0000";
		B<="0000";
	END IF;
END IF;

SQ_Y7_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_Y7,SQ_Y7_OUT'length));	
SQ_x7_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_x7,SQ_x7_OUT'length));	
SQ_Y1_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_Y1,SQ_Y1_OUT'length));	
SQ_x1_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_x1,SQ_x1_OUT'length));	
SQ_Y2_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_Y2,SQ_Y2_OUT'length));	--BOLA 
SQ_x2_OUT<=STD_LOGIC_VECTOR(to_unsigned(SQ_x2,SQ_x2_OUT'length));	-- BOLA





END PROCESS;
END ARCHITECTURE;
	