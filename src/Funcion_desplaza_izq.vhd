library IEEE;
use IEEE.std_logic_1164.all;

entity Funcion_desplaza_izq is
  port (
    A         : in  std_logic_vector (31 downto 0);
    B         : in  std_logic_vector (4 downto 0);
    Y         : out std_logic_vector (31 downto 0)
  
  );
end Funcion_desplaza_izq;

architecture arch of Funcion_desplaza_izq is
  signal s16,s8,s4,s2,s1 : std_logic_vector(31 downto 0);
  constant relleno  : std_logic_vector(15 downto 0):=(others=> '0');
  begin
   
    s1  <= s2  (31-1  downto 0) &relleno(1 -1 downto 0) when B(0) else s2;
    s2  <= s4  (31-2  downto 0) &relleno(2 -1 downto 0) when B(1) else s4;
    s4  <= s8  (31-4  downto 0) &relleno(4 -1 downto 0) when B(2) else s8;
    s8  <= s16 (31-8  downto 0) &relleno(8 -1 downto 0) when B(3) else s16;
    s16 <= A   (31-16 downto 0) &relleno(16-1 downto 0) when B(4) else A;
    
    Y <= S1;
end arch;