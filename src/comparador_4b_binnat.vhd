library IEEE;
use IEEE.std_logic_1164.all;

entity comparador_4b_binnat is
  port (
    A : in  std_logic_vector (3 downto 0);
    B : in  std_logic_vector (3 downto 0);
    mayor : out std_logic;
    menor : out std_logic;
    igual : out std_logic
  );
end comparador_4b_binnat;


architecture arch of comparador_4b_binnat is
signal u,v,w :std_logic;
  begin
  mayor <= u;
  menor <= v;
  igual <= w;
  
  u <= (A(3) and not B(3))
    or ((A(3) xnor B(3) )and (A(2) and not B(2)))
    or ((A(3) xnor B(3) )and (A(2) xnor B(2))and (A(1) and not B(1)))
    or ((A(3) xnor B(3) )and (A(2) xnor B(2))and (A(1) xnor B(1)) and (A(0) and not B(0)));

  v <= (B(3) and not A(3))
    or ((A(3) xnor B(3) )and (B(2) and not A(2)))
    or ((A(3) xnor B(3) )and (A(2) xnor B(2))and (B(1) and not A(1)))
    or ((A(3) xnor B(3) )and (A(2) xnor B(2))and (A(1) xnor B(1)) and (B(0) and not A(0)));

  w <= (A(3) xnor B(3)) and (A(2) xnor B(2)) and (A(1) xnor B(1)) and (A(0) xnor B(0));

  
end arch;