LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

--VGA 1280x1024
--------------------------------------------------------
ENTITY VGA_PRINTC IS
    PORT(   
			CLOCK_50   : IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		   buttons	  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			rst		  : IN  STD_LOGIC;
			start		  : IN  STD_LOGIC;
			Hsync      : OUT STD_LOGIC;
			Vsync 	  : OUT STD_LOGIC;
			R   	     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			G   		  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			B          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			one_seg    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			two_seg    : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			three_seg  : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
			four_seg   : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)); 

END ENTITY;
--------------------------------------------------------
ARCHITECTURE MAIN OF VGA_PRINTC IS

SIGNAL VGACLK,RESET,VGACLK_P: STD_LOGIC;
SIGNAL sel_XB     :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL sel_YB     :  STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL SQ_Y7_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL SQ_x7_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL SQ_Y1_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL SQ_x1_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL SQ_Y2_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL SQ_x2_OUT  :  STD_LOGIC_VECTOR(10 DOWNTO 0); 
SIGNAL techo: std_LOGIC; 
SIGNAL Piso: std_LOGIC; 
SIGNAL TOQUES_OUT :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL start_debo : STD_LOGIC;
SIGNAL start_1 : STD_LOGIC; 
SIGNAL buttons_debo  :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL P  :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL Gol_der_OUT  :  STD_LOGIC_VECTOR(3 DOWNTO 0); 
SIGNAL Gol_izq_OUT  :  STD_LOGIC_VECTOR(3 DOWNTO 0); 
SIGNAL VEL     : std_LOGIC_VECTOR (3 DOWNTO 0); 

--------------------------------------------------------


--------------------------------------------------------

    COMPONENT PLL IS
        PORT (
            clk_in_clk  : IN  STD_LOGIC := 'X'; -- clk
            reset_reset : IN  STD_LOGIC := 'X'; -- reset
            clk_out_clk : OUT STD_LOGIC         -- clk
        );
    END COMPONENT PLL;
	 
    Component PLL_1000 is
        port (
            clk_clk      : in  std_logic := 'X'; -- clk
            reset_reset  : in  std_logic := 'X'; -- reset
            clk_1000_clk : out std_logic         -- clk
        );
    end component PLL_1000;
--------------------------------------------------------
COMPONENT VGA_SYNC IS
PORT(
	clk        : IN  STD_LOGIC;
	buttons	  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
	sel_XB     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	sel_YB     : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
--	start		  : IN STD_LOGIC;
	Hsync      : OUT STD_LOGIC;
	Vsync 	  : OUT STD_LOGIC;
	R   	     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	G   		  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	B          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
	SQ_Y7_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	SQ_x7_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	SQ_Y1_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	SQ_x1_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	SQ_Y2_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	SQ_x2_OUT  : OUT STD_LOGIC_VECTOR(10 DOWNTO 0); 
	Techo      : OUT STD_LOGIC; 
	Piso       : OUT STD_LOGIC;
	VEL        : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	GOL_IZQ	  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	GOL_DER	  : IN STD_LOGIC_VECTOR(3 DOWNTO 0));
	END COMPONENT VGA_SYNC;
	
	
COMPONENT control_pong IS
	PORT(	clk        : IN  STD_LOGIC;
			clk500        : IN STD_LOGIC;
	      rst        : IN  STD_LOGIC;
	      SQ_Y7_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x7_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y1_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x1_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_Y2_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			SQ_x2_OUT  : IN STD_LOGIC_VECTOR(10 DOWNTO 0); 
			sel_XBB     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			sel_YBB    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 
			Techo      : IN STD_LOGIC; 
			Piso       : IN STD_LOGIC;
			start		  : IN STD_LOGIC;
			TOQUES_OUT : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			P			  : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			Gol_der_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			Gol_izq_OUT: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 
			VEL   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END COMPONENT;

COMPONENT Debouncer IS
		PORT 	 (	Clk   		:	 IN  STD_LOGIC;
					Rst   		:   IN  STD_LOGIC;
					Ena   		:   IN  STD_LOGIC;
					Max_tick		:   OUT STD_LOGIC
					);
END COMPONENT;	

COMPONENT bin_toseg IS
PORT( swch : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	   seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END COMPONENT bin_toseg;


	BEGIN
	C1: VGA_SYNC PORT MAP (VGACLK,buttons,sel_XB,sel_YB,Hsync,Vsync,R,G,B,SQ_Y7_OUT, SQ_x7_OUT,SQ_Y1_OUT,SQ_X1_OUT,SQ_Y2_OUT,SQ_x2_OUT,Techo, Piso, VEL,Gol_izq_OUT,Gol_der_OUT);
	C2: PLL PORT MAP (CLOCK_50(0),RESET,VGACLK);
	C22: PLL_1000 PORT MAP (CLOCK_50(0),RESET,VGACLK_P);
	C3: control_pong PORT MAP  (VGACLK,VGACLK,RESET, SQ_Y7_OUT, SQ_x7_OUT,SQ_Y1_OUT,SQ_X1_OUT,SQ_Y2_OUT,SQ_x2_OUT,SEL_XB, SEL_YB, Techo, Piso, start_1, TOQUES_OUT,P, Gol_der_OUT, Gol_izq_OUT,VEL); 
	S1: bin_toseg PORT MAP(Gol_izq_OUT,one_seg);
	S2: bin_toseg PORT MAP("1100",two_seg);
	S3: bin_toseg PORT MAP(P,three_seg);
	S4: bin_toseg PORT MAP(Gol_der_OUT,four_seg);


	RESET <= rst; 
	start_1 <=start;
	
	END ARCHITECTURE;
	
	