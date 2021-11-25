
LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all; 
------------------------------------

--VGA 1280x1024 
-- 42 limite superior y 
-- 1021 limite inferior Y 

ENTITY control_pong IS
	PORT(	clk        : IN STD_LOGIC; 
			clk500	  : IN STD_LOGIC;
	      rst        : IN STD_LOGIC; 
			SQ_Y7_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x7_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y1_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x1_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y2_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x2_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			sel_XBB    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			sel_YBB    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
			Techo      : IN STD_LOGIC; 
			Piso       : IN STD_LOGIC;
			start		  : IN STD_LOGIC;
			TOQUES_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			P			  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			Gol_der_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			Gol_izq_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
			VEL   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END ENTITY;
-------------------------------------
ARCHITECTURE structural OF control_pong IS  

	TYPE state IS(st_iddle,st_inicial,st_der_ab,st_der_arr, st_izq_ab,st_izq_arr, st_gol_izq, st_gol_der);
   SIGNAL pr_state : state:= st_iddle;
	SIGNAL nx_state : state := st_iddle;
	SIGNAL sel_XB: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL sel_YB: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL TOQUES: INTEGER RANGE 0 TO 20:=0;
   SIGNAL ena_gol_izq : STD_LOGIC;
	SIGNAL ena_gol_der: STD_LOGIC;
	SIGNAL gol_izq, GOL_IZQ_1: STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	SIGNAL gol_der, GOL_DER_1:STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	SIGNAL VEL_ACT, VEL_NEXT:STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
	SIGNAL gol_izq_NEXT: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL gol_der_NEXT:STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL gol_izq_NEXT_1: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL gol_der_NEXT_1:STD_LOGIC_VECTOR(3 DOWNTO 0);
   SIGNAL izq, der, rst_A, rst_vel:  std_LOGIC := '0';	
	SIGNAL enaToques, enaToques_1 : STD_LOGIC;

   

BEGIN
                              
	 
	 PROCESS (rst, clk500)
	 BEGIN
	
		IF(rst='1') THEN
			pr_state<=st_iddle;
		ELSIF (rising_edge(clk500)) THEN
			pr_state <=nx_state;
		END IF;
	END PROCESS;
	 
	 PROCESS (nx_state, pr_state, SQ_Y7_OUT, SQ_x7_OUT, SQ_Y1_OUT, SQ_x1_OUT, SQ_Y2_OUT, SQ_x2_OUT, techo, piso, start, izq, der, enaToques)
	 
	VARIabLE uno: STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
   VARIABLE count_der:  std_LOGIC_VECTOR (3 downto 0); 
	VARIABLE count_izq:  std_LOGIC_VECTOR (3 downto 0);
	 
	 BEGIN
	 
        CASE pr_state IS
            WHEN st_iddle =>
							 SEL_XB<="11";
							 SEL_YB<="11";
							 
							 ena_gol_der<='0';
							ena_gol_izq<='0';
							
				
							 IF ( NOT (start='1') ) THEN
							P<="1100";
							    rst_vel <= '0';
							    nx_state <= st_der_arr;
							 ELSE 
							 p <="1100";
							 nx_state <= st_iddle ;
							 END IF;
							 izq <= '0'; 
					       DER <= '0';
									
				WHEN st_inicial =>
	
							
						IF (IZQ='1' AND DER='0') THEN				
						
							IF ((GOL_IZQ="1010")) THEN
								P<="1011";
								rst_A<='1';
								ena_gol_izq<='0';
								ena_gol_der<='0';

								nx_state <= st_iddle;
							ELSIF ((GOL_IZQ < "1010")) THEN
								 P<="1100";
								 rst_A<='0';
								 ena_gol_izq<='0';
								 ena_gol_der<='0';

								 nx_state <= st_iddle;
							ELSE 
							   p <= "1100"; 
								ena_gol_der<='0';
								ena_gol_izq<='0';
								nx_state <= st_der_arr;
							END IF;
						ELSIF(DER='1' AND IZQ='0') THEN
						
							IF ((GOL_DER="1010")) THEN
								P<="1011";
								rst_A<='1';
								ena_gol_der<='0';
								ena_gol_izq<='0';
								nx_state <= st_iddle;
							ELSIF ((GOL_DER < "1010")) THEN
								 P<="1100";
								 rst_A<='0';
								 ena_gol_der<='0';
								ena_gol_izq<='0';
								 nx_state <= st_iddle;
							ELSE 
							   p <= "1100"; 
								ena_gol_der<='0';
								ena_gol_izq<='0';
								nx_state <= st_izq_arr;
							END IF; 
						ELSE 
                  p <= "1100"; 
						ena_gol_der<='0';
						ena_gol_izq<='0';

                  nx_state <= st_iddle;
						
						END IF;
						
							
				WHEN st_der_ab =>
							 SEL_XB<="01";
							 SEL_YB<="01";
							 izq <= '0'; 
							 der <= '0';
							 p <= "1100"; 
							 
							 IF (piso ='1' OR (SQ_Y2_OUT>969 AND SQ_Y2_OUT<986))  THEN 
								enaToques<='0';
								nx_state<=st_der_arr;
							 ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614) AND (((SQ_Y2_OUT) > SQ_Y1_OUT) AND (SQ_Y2_OUT < (SQ_Y1_OUT +100)))) THEN --> 1630 AND SQ_X2_OUT<1690
							   enaToques<='0';
								nx_state<=st_izq_arr;
							 ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614)AND ((SQ_Y2_OUT > (SQ_Y1_OUT+99)) AND (SQ_Y2_OUT < (SQ_Y1_OUT+201) ))) THEN --> 1630 AND SQ_X2_OUT<1690
							   enaToques<='0';
								nx_state<=st_izq_ab;
							 ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614) AND (NOT(((SQ_Y2_OUT > SQ_Y1_OUT) AND (SQ_Y2_OUT< (SQ_Y1_OUT +201) ))))) THEN
							   enaToques<='0';
								nx_state<= st_gol_der;
							 ELSE
								enaToques<='0';
							  nx_state<=st_der_ab;
							  END IF;
							 
				WHEN st_der_arr => 
							 SEL_XB<="01"; 
							 SEL_YB<="10";
							 izq <= '0'; 
							 der <= '0';
							 P<="1100";
							 
							 IF ((techo ='1')OR (SQ_Y2_OUT>39 AND SQ_Y2_OUT<56)) THEN
								enaToques<='0';
								nx_state<=st_DER_ab;
							 ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614) AND ((SQ_Y2_OUT > SQ_Y1_OUT) AND (SQ_Y2_OUT < (SQ_Y1_OUT +100)))) THEN
								enaToques<='0';
								nx_state<= st_izq_arr;
							  ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614)AND ((SQ_Y2_OUT > (SQ_Y1_OUT+99)) AND (SQ_Y2_OUT < (SQ_Y1_OUT+201) ))) THEN
							   enaToques<='0';
								nx_state<= st_izq_ab;
							ELSIF((sQ_X2_OUT>1596 AND SQ_X2_OUT<1614) AND (NOT(((SQ_Y2_OUT > SQ_Y1_OUT) AND (SQ_Y2_OUT< (SQ_Y1_OUT +201) ))))) THEN
								enaToques<='0';
							   nx_state<= st_gol_der;								
							 ELSE
								enaToques<='0';
								nx_state<= st_der_arr;
							 END IF;
							  
				WHEN st_izq_arr => 
							 SEL_XB<="10";
						    SEL_YB<="10";
							 P<="1100";
							 izq <= '0'; 
							 der <= '0';
							
							 IF(techo ='1' OR (SQ_Y2_OUT>39 AND SQ_Y2_OUT<56)) THEN                    -- 42 
								enaToques<='0';
								nx_state<=st_izq_ab;
							 
							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND ((SQ_Y2_OUT > SQ_Y7_OUT) AND (SQ_Y2_OUT< (SQ_Y7_OUT + 100)))) THEN --SQ_X2_OUT>353 and SQ_X2_OUT<447
								
								enaToques<='1';
								nx_state<= st_der_arr;

							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND ((SQ_Y2_OUT > (SQ_Y7_OUT+99)) AND (SQ_Y2_OUT< (SQ_Y7_OUT +201)))) THEN --SQ_X2_OUT>353 and SQ_X2_OUT<447
								enaToques<='1';
								nx_state<= st_der_ab;
						    
							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND (NOT((SQ_Y2_OUT > SQ_Y7_OUT)AND (SQ_Y2_OUT< (SQ_Y7_OUT +201) )))) THEN
								enaToques<='0';
								nx_state<= st_gol_izq;
							 ELSE
								enaToques<='0';
								nx_state<= st_izq_arr;
							 END IF;
				WHEN st_izq_ab =>
							 SEL_XB<="10";
						    SEL_YB<="01";
							 izq <= '0'; 
							 der <= '0';
							 P<="1100";
							
							 IF(piso ='1' OR (SQ_Y2_OUT>969 AND SQ_Y2_OUT<986)) THEN  
								enaToques<='0';
								nx_state<=st_izq_arr;

							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND ((SQ_Y2_OUT > SQ_Y7_OUT) AND (SQ_Y2_OUT< (SQ_Y7_OUT + 100)))) THEN
								enaToques<='1';
								nx_state<= st_der_ab;
							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND ((SQ_Y2_OUT > (SQ_Y7_OUT+99)) AND (SQ_Y2_OUT< (SQ_Y7_OUT +201)))) THEN 
								enaToques<='1';
							    nx_state<= st_der_arr;
							
							 ELSIF((SQ_X2_OUT>446 AND SQ_X2_OUT<464) AND (NOT((SQ_Y2_OUT > SQ_Y7_OUT)AND (SQ_Y2_OUT< (SQ_Y7_OUT +201) ))))THEN
								enaToques<='0';
								nx_state<= st_gol_izq;
							 ELSE
								enaToques<='0';
								nx_state<= st_izq_ab;
							 END IF; 
							 
				WHEN st_gol_izq =>
							SEL_XB<="11";
							SEL_YB<="11";
							izq <= '1'; 
							der <= '0'; 
							P<="1100";
							ena_gol_der<='0';
							ena_gol_izq<='1';
							rst_vel <= '1'; 
							nx_state <= st_inicial; 

							
				WHEN st_gol_der =>
							SEL_XB<="11";
							SEL_YB<="11";
							der <= '1'; 
							izq <= '0';
							P<="1100";
							ena_gol_der<='1';
							ena_gol_izq<='0';
							rst_vel <= '1'; 
							nx_state <= st_inicial; 
				

		END CASE;
						
		END PROCESS;	
		
-- DERECHA 		
				
		derr:entity work.REGISTRO_B
		PORT MAP(
			clk =>clk500,
		  rst =>rst_A,
		  ena =>ena_gol_der,
		  data =>GOL_DER_NEXT,
		  q =>GOL_DER);
		  
		  GOL_DER_OUT <= GOL_DER;	
		  

		Sum_der:entity work.sumador
		PORT MAP (	
		dataa => GOL_DER,
		datab	=> "0001",
		result =>GOL_DER_NEXT );
		 

		 
--- izquierda 		  
		izqq:entity work.REGISTRO_B
		PORT MAP(
			clk =>clk500,
		  rst =>rst_A,
		  ena =>ena_gol_izq,
		  data =>GOL_IZQ_NEXT,
		  q =>GOL_IZQ);
		  
		 GOL_izq_OUT <= GOL_IZQ; 
		 
		 
		Sum_izq:entity work.sumador
		PORT MAP (	
		dataa => GOL_IZQ,
		datab	=> "0001",
		result => GOL_IZQ_NEXT);
		

		
		
		--- VELOCIDAD 
		
		 
		Sum_VELL:entity work.sumador
		PORT MAP (	
		dataa => VEL_ACT,
		datab	=> "0001",
		result => VEL_NEXT);
		
		VELL:entity work.REGISTRO_B
		PORT MAP(
			clk =>clk500,
		  rst =>rst_vel,
		  ena => enaToques_1,
		  data =>VEL_NEXT,
		  q => VEL_ACT);
		  
		enaToques_1 <= enaToques WHEN VEL_ACT<"1001" ELSE '0';
					
		 vel <= vel_ACT; 

		 		
	 
		SEL_XBB <= SEL_XB; 
		SEL_YBB <= SEL_YB; 
		TOQUES_OUT <=CONV_STD_LOGIC_VECTOR(TOQUES,TOQUES_OUT'length);


	
					
END ARCHITECTURE; 





