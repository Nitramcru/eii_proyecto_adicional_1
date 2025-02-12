library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FuncionOR is
  port (
    entrada1 : in  std_logic_vector (31 downto 0);
    entrada2 : in  std_logic_vector (31 downto 0);
    salida  : out  std_logic_vector (31 downto 0)


    
  );
end FuncionOR;

architecture arch of FuncionOR is

  begin
  salida <= entrada1 or entrada2;
end arch;