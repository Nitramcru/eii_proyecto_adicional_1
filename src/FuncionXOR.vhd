library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FuncionXOR is
  port (
    entrada1 : in  std_logic_vector (31 downto 0);
    entrada2 : in  std_logic_vector (31 downto 0);
    salida   : out  std_logic_vector (31 downto 0)
  );
end FuncionXOR;

architecture arch of FuncionXOR is
begin
  salida <= entrada1 xor entrada2;
end arch;