LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;    
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
ENTITY freq_div1 IS 
PORT ( clkin : IN std_logic ;
       clkout :OUT std_logic ) ; 
         END freq_div1  ;

ARCHITECTURE A OF freq_div1 IS 
BEGIN 
PROCESS (clkin )

   variable count  : std_logic_vector (1 downto 0) := "00";
begin
if (rising_edge (clkin )) THEN 
          count := count+1 ;
        end if;
        clkout <= count(0) ;
    end process ;
     END A ;