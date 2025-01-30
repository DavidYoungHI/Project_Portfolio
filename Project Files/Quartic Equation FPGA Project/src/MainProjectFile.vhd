LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

ENTITY difference IS
   PORT (clk     : IN    STD_LOGIC ;
         reset_l : IN    STD_LOGIC ;
         An      : OUT   STD_LOGIC_VECTOR(7 DOWNTO 0) ;
         ca_OUT  : OUT   STD_LOGIC ;
         cb_OUT  : OUT   STD_LOGIC ;
         cc_OUT  : OUT   STD_LOGIC ;
         cd_OUT  : OUT   STD_LOGIC ;
         ce_OUT  : OUT   STD_LOGIC ;
         cf_OUT  : OUT   STD_LOGIC ;
         cg_OUT  : OUT   STD_LOGIC ;
         DP      : OUT   STD_LOGIC);
END difference ;

ARCHITECTURE mine OF difference IS

--Declaring signals
   SIGNAL   g : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   h : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   i : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   j : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   x : STD_LOGIC_VECTOR(7 DOWNTO 0) ;
   SIGNAL   f : STD_LOGIC_VECTOR(31 DOWNTO 0) ;
   SIGNAL   reset_1_tmp : STD_LOGIC ;
   SIGNAL   reset_1_sync : STD_LOGIC ;
   SIGNAL   ROOTS : STD_LOGIC_VECTOR(31 DOWNTO 0) ; --Holds the four roots found in the roots capture process.
   SIGNAL   cntROOTS : STD_LOGIC_VECTOR(3 DOWNTO 0) ; -- counter for the roots capture process.
   SIGNAL   nBitCounter : STD_LOGIC_VECTOR(19 DOWNTO 0) ; -- Counter for the n-bit display.
   
   --Adding hex2cathod Module
   COMPONENT hex2cathode
   PORT (ahexchar : IN    STD_LOGIC_VECTOR(3 DOWNTO 0) ;
         ca       : OUT   STD_LOGIC ;
         cb       : OUT   STD_LOGIC ;
         cc       : OUT   STD_LOGIC ;
         cd       : OUT   STD_LOGIC ;
         ce       : OUT   STD_LOGIC ;
         cf       : OUT   STD_LOGIC ;
         cg       : OUT   STD_LOGIC) ;
   END COMPONENT ;
   
   --Internal Signals for hex2cathode
   SIGNAL      ahexchar_INT :    STD_LOGIC_VECTOR(3 DOWNTO 0) ;
   SIGNAL      ca_INT       :    STD_LOGIC ;
   SIGNAL      cb_INT       :    STD_LOGIC ;
   SIGNAL      cc_INT       :    STD_LOGIC ;
   SIGNAL      cd_INT       :    STD_LOGIC ;
   SIGNAL      ce_INT       :    STD_LOGIC ;
   SIGNAL      cf_INT       :    STD_LOGIC ;
   SIGNAL      cg_INT       :    STD_LOGIC ;
   
   --Internal Signals for output of the decoder.
   SIGNAL      AN_int       :    STD_LOGIC_VECTOR(7 DOWNTO 0) ;

BEGIN
    --Implementing Reset Synchronizer.
   synchronizer:PROCESS(clk)
   BEGIN
        IF (clk'event AND clk = '1') THEN
            reset_1_tmp <= reset_l ;
            reset_1_sync <= reset_1_tmp ;
        END IF ;
   END PROCESS ;
    
   registers:PROCESS(clk)
   BEGIN
        IF (clk'event AND clk = '1') THEN
           IF (reset_1_sync = '0') THEN -- when the reset button is held down.
              f <= "00000000010000000000000000000000" ;
              g <= "11111111111110001100010100010001" ;
              h <= "00000000000000001000011001101110" ;
              i <= "11111111111111111111101010000100" ;
              j <= "00000000000000000000000000011000" ;
              x <= "00000000" ;
           ELSE
              f <= f + g ;
              g <= g + h ;
              h <= h + i ;
              i <= i + j ;
              x <= x + 1 ;
           END IF ;
        END IF ;
   END PROCESS ;

   --Roots Capture Process.
   RootsCapture:PROCESS(clk)
   BEGIN
        IF (clk'event AND clk = '1') THEN
           IF (reset_1_sync = '0') THEN
              ROOTS <= "00000000000000000000000000000000" ;
              cntROOTS <= "0000" ;
           ELSE
              IF (f = 0 AND cntROOTS = 0) THEN --The first root. 
                 ROOTS(7 DOWNTO 0) <= x ;
                 cntROOTS <=  cntROOTS + 1 ;
                 
              ELSIF (f = 0 AND  cntROOTS = 1) THEN --The second root
                ROOTS(15 DOWNTO 8) <= x ;
                cntROOTS <=  cntROOTS + 1 ;
                
              ELSIF (f = 0 AND cntROOTS = 2) THEN --The third root
                ROOTS(23 DOWNTO 16) <= x ;
                cntROOTS <= cntROOTS + 1;
                
              ELSIF (f = 0 AND cntROOTS = 3) THEN --The fourth root
                ROOTS(31 DOWNTO 24) <= x ;
                cntROOTS <= cntROOTS + 1;
                
              ELSE -- Do nothing. Let the polynomial f(x) overflow.

              END IF ;
           END IF ;
        END IF ;
   END PROCESS RootsCapture ;
   
   --The Counter
   dispCounter:PROCESS(clk)
   BEGIN
        IF (clk'event AND clk = '1') THEN
           IF (reset_1_sync = '0') THEN
              nBitCounter <= "00000000000000000000" ; --Resetting the n-bit counter.
           ELSE
              nBitCounter <= nBitCounter + 1 ;
           END IF ;
        END IF ;      
   END PROCESS dispCounter ; 
   
   --The decoder that links to the anodes.
   WITH nBitCounter(19 DOWNTO 17) SELECT
      AN_int <= "11111110" WHEN "000", -- Light up the furthest right display AN(0).
                   "11111101" WHEN "001", -- Light up the 2nd furthest right display AN(1).
                   "11111011" WHEN "010",  
                   "11110111" WHEN "011",  
                   "11101111" WHEN "100", 
                   "11011111" WHEN "101",  
                   "10111111" WHEN "110",  
                   "01111111" WHEN OTHERS;   
   
   --The MUX To link with the hex2cathode. (Combinatational logic.)
      WITH nBitCounter(19 DOWNTO 17) SELECT
         ahexchar_INT <= ROOTS(3 DOWNTO 0) WHEN "000", --tell hex2cathode to show 1st half of the 1st root
                     ROOTS(7 DOWNTO 4) WHEN "001", --tell hex2cathode to show 2nd half of the 1st root
                     ROOTS(11 DOWNTO 8) WHEN "010",  --tell hex2cathode to show 1st of the 2nd root.
                     ROOTS(15 DOWNTO 12) WHEN "011",  
                     ROOTS(19 DOWNTO 16) WHEN "100", 
                     ROOTS(23 DOWNTO 20) WHEN "101",  
                     ROOTS(27 DOWNTO 24) WHEN "110",  
                     ROOTS(31 DOWNTO 28) WHEN OTHERS;  
   
      --THE REGISTER OF OUTPUT FLIP FLOPS.
      outputRegister:PROCESS(clk)
         BEGIN
            IF (clk'event AND clk = '1') THEN
            ca_OUT <= ca_INT ;
            cb_OUT <= cb_INT ;
            cc_OUT <= cc_INT ;
            cd_OUT <= cd_INT ;
            ce_OUT <= ce_INT ;
            cf_OUT <= cf_INT ;
            cg_OUT <= cg_INT ;
            AN <= AN_INT ;
               
            
            END IF ;
         END PROCESS outputRegister ;
         
   
   --Port mapping the Hex to Cathode Module.
   Add1:hex2cathode
   PORT MAP(ahexchar => ahexchar_INT ,
            ca => ca_INT ,
            cb => cb_INT ,
            cc => cc_INT ,
            cd => cd_INT ,
            ce => ce_INT ,
            cf => cf_INT ,
            cg => cg_INT );

   --Setting the DP output to be '1', as written in the diagram.
   DP <= '1' ;

END mine ;
