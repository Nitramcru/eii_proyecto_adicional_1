library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Funcion_SUMA_RESTA is
  port (
    entrada1 : in  std_logic_vector (31 downto 0);
    entrada2 : in  std_logic_vector (31 downto 0);
    Seleccion  : in  std_logic;
    salida  : out  std_logic_vector (31 downto 0)
  );

end Funcion_SUMA_RESTA;

architecture arch of Funcion_SUMA_RESTA is
  signal  Suma : std_logic_vector(31 downto 0);
  signal  Resta : std_logic_vector(31 downto 0);
begin

  Suma  <= std_logic_vector(unsigned(entrada1) + unsigned(entrada2));
  Resta <= std_logic_vector(unsigned(entrada1) - unsigned(entrada2));

  salida <= Suma when Seleccion = '0' else Resta;

end arch;