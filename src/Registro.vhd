library IEEE;
use IEEE.std_logic_1164.all;

entity Registro is
  port (
    clk : in  std_logic;
    D :   in  std_logic_vector (31 downto 0);
    hab:  in  std_logic;
    reset:  in  std_logic;
    Q :   out std_logic_vector (31 downto 0)
  );
end Registro;

architecture arch of Registro is
begin
  U1: process (clk)
  begin
    if rising_edge (clk) then
      if reset then
        Q <= 32x"0";
      elsif hab then
        Q <= D;
      end if;
    end if;
  end process;
end arch;