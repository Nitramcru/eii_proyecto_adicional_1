library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
  port (
    D : in  std_logic;
    hab : in  std_logic:='1';
    clk : in  std_logic;
    Q : out std_logic
  );
end ffd;

architecture arch of ffd is
begin
  
  U: process (clk)
  begin
    if rising_edge (clk) then
      if hab then
        Q <= D;
      end if;
    end if;
  end process;

end arch;
