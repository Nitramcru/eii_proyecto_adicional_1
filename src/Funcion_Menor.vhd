library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Funcion_Menor is
  port (
    entradaA   : in  std_logic_vector (31 downto 0);
    entradaB   : in  std_logic_vector (31 downto 0);
    Seleccion  : in  std_logic;
    
    salida     : out std_logic

  );

end Funcion_Menor;

architecture arch of Funcion_Menor is
begin

  salida <= signed(entradaA) ?< signed (entradaB) when seleccion = '0' else unsigned(entradaA) ?< unsigned (entradaB);


end arch;
