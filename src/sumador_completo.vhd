library IEEE;
use IEEE.std_logic_1164.all;

entity sumador_completo is
  port (
    A : in  std_logic;
    B : in  std_logic;
    Ci: in  std_logic;
    Co: in  std_logic;
    Y : out std_logic
  );
end sumador_completo;

architecture arch of sumador_completo is
begin
  Y <= A xor B xor Ci;
  Co <= (A and B) or (A and Ci) or (B and Ci);
end arch;
