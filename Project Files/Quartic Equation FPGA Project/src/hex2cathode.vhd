LIBRARY IEEE ;
USE IEEE.STD_LOGIC_1164.ALL ;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

ENTITY hex2cathode IS
   PORT (ahexchar : IN    STD_LOGIC_VECTOR(3 DOWNTO 0) ;
         ca       : OUT   STD_LOGIC ;
         cb       : OUT   STD_LOGIC ;
         cc       : OUT   STD_LOGIC ;
         cd       : OUT   STD_LOGIC ;
         ce       : OUT   STD_LOGIC ;
         cf       : OUT   STD_LOGIC ;
         cg       : OUT   STD_LOGIC) ;
END hex2cathode ;

ARCHITECTURE mine OF hex2cathode IS

BEGIN

   WITH ahexchar SELECT
      ca <= '0' WHEN "0000" ,
            '1' WHEN "0001" ,
            '0' WHEN "0010" ,
            '0' WHEN "0011" ,
            '1' WHEN "0100" ,
            '0' WHEN "0101" ,
            '0' WHEN "0110" ,
            '0' WHEN "0111" ,
            '0' WHEN "1000" ,
            '0' WHEN "1001" ,
            '0' WHEN "1010" ,
            '1' WHEN "1011" ,
            '0' WHEN "1100" ,
            '1' WHEN "1101" ,
            '0' WHEN "1110" ,
            '0' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      cb <= '0' WHEN "0000" ,
            '0' WHEN "0001" ,
            '0' WHEN "0010" ,
            '0' WHEN "0011" ,
            '0' WHEN "0100" ,
            '1' WHEN "0101" ,
            '1' WHEN "0110" ,
            '0' WHEN "0111" ,
            '0' WHEN "1000" ,
            '0' WHEN "1001" ,
            '0' WHEN "1010" ,
            '1' WHEN "1011" ,
            '1' WHEN "1100" ,
            '0' WHEN "1101" ,
            '1' WHEN "1110" ,
            '1' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      cc <= '0' WHEN "0000" ,
            '0' WHEN "0001" ,
            '1' WHEN "0010" ,
            '0' WHEN "0011" ,
            '0' WHEN "0100" ,
            '0' WHEN "0101" ,
            '0' WHEN "0110" ,
            '0' WHEN "0111" ,
            '0' WHEN "1000" ,
            '0' WHEN "1001" ,
            '0' WHEN "1010" ,
            '0' WHEN "1011" ,
            '1' WHEN "1100" ,
            '0' WHEN "1101" ,
            '1' WHEN "1110" ,
            '1' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      cd <= '0' WHEN "0000" ,
            '1' WHEN "0001" ,
            '0' WHEN "0010" ,
            '0' WHEN "0011" ,
            '1' WHEN "0100" ,
            '0' WHEN "0101" ,
            '0' WHEN "0110" ,
            '1' WHEN "0111" ,
            '0' WHEN "1000" ,
            '1' WHEN "1001" ,
            '1' WHEN "1010" ,
            '0' WHEN "1011" ,
            '0' WHEN "1100" ,
            '0' WHEN "1101" ,
            '0' WHEN "1110" ,
            '1' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      ce <= '0' WHEN "0000" ,
            '1' WHEN "0001" ,
            '0' WHEN "0010" ,
            '1' WHEN "0011" ,
            '1' WHEN "0100" ,
            '1' WHEN "0101" ,
            '0' WHEN "0110" ,
            '1' WHEN "0111" ,
            '0' WHEN "1000" ,
            '1' WHEN "1001" ,
            '0' WHEN "1010" ,
            '0' WHEN "1011" ,
            '0' WHEN "1100" ,
            '0' WHEN "1101" ,
            '0' WHEN "1110" ,
            '0' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      cf <= '0' WHEN "0000" ,
            '1' WHEN "0001" ,
            '1' WHEN "0010" ,
            '1' WHEN "0011" ,
            '0' WHEN "0100" ,
            '0' WHEN "0101" ,
            '0' WHEN "0110" ,
            '1' WHEN "0111" ,
            '0' WHEN "1000" ,
            '0' WHEN "1001" ,
            '0' WHEN "1010" ,
            '0' WHEN "1011" ,
            '0' WHEN "1100" ,
            '1' WHEN "1101" ,
            '0' WHEN "1110" ,
            '0' WHEN "1111" ,
            '1' WHEN OTHERS ;

   WITH ahexchar SELECT
      cg <= '1' WHEN "0000" ,
            '1' WHEN "0001" ,
            '0' WHEN "0010" ,
            '0' WHEN "0011" ,
            '0' WHEN "0100" ,
            '0' WHEN "0101" ,
            '0' WHEN "0110" ,
            '1' WHEN "0111" ,
            '0' WHEN "1000" ,
            '0' WHEN "1001" ,
            '0' WHEN "1010" ,
            '0' WHEN "1011" ,
            '1' WHEN "1100" ,
            '0' WHEN "1101" ,
            '0' WHEN "1110" ,
            '0' WHEN "1111" ,
            '1' WHEN OTHERS ;    

END mine ;
