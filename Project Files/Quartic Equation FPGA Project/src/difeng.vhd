LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

ENTITY difference IS
   PORT (clk     : IN    STD_LOGIC ;
         reset_l : IN    STD_LOGIC ;
         f       : INOUT STD_LOGIC_VECTOR(31 DOWNTO 0)) ;
END difference ;

ARCHITECTURE mine OF difference IS

   SIGNAL   g : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   h : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   i : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   j : STD_LOGIC_VECTOR(31 DOWNTO 0) ;

BEGIN

   registers:PROCESS(clk)
   BEGIN
        IF (clk'event AND clk = '1') THEN
           IF (reset_l = '0') THEN
              f <= "00000000000000000000000000000001" ;
              g <= "11111111111111111111111111111110" ;
              h <= "00000000000000000000000000000110" ;
              i <= "00000000000000000000000000011110" ;
              j <= "00000000000000000000000000011000" ;
           ELSE
              f <= f + g ;
              g <= g + h ;
              h <= h + i ;
              i <= i + j ;
           END IF ;
        END IF ;
   END PROCESS ;

END mine ;
