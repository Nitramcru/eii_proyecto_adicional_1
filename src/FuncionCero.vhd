library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FuncionCero is
  port (
    entrada : in  std_logic_vector (31 downto 0);
    salida  : out std_logic
  );
end FuncionCero;




architecture cero of FuncionCero is
begin
 
  salida <= '1' when entrada = X"00000000" else '0';

end cero;