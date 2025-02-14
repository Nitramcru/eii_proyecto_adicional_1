library IEEE;
use IEEE.std_logic_1164.all;

entity microcontrolador is
  
  port (
    A : in  std_logic;
    B : in  std_logic;
    Y : out std_logic
  );
end microcontrolador;

architecture arch of microcontrolador is
begin
  Y <= A and B;
end arch;
