library IEEE;
use IEEE.std_logic_1164.all;

entity Condicion_branch is
  port (
    funct3: in  std_logic_vector (2 downto 0);
    Z_branch : out std_logic
  );
end Condicion_branch;

architecture arch of Condicion_branch is
begin
  
  with funct3 select
  Z_branch <= '1' when "000" | "101" | "111",  -- beq, bge, bgev
              '0' when others;                 -- beq, bge, bgev
  
  
end arch;
