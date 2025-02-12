library IEEE;
use IEEE.std_logic_1164.all;

entity Valor_inmediato is
  port (
    instr : in  std_logic_vector (31 downto 7);
    sel : in  std_logic_vector (2 downto 0);
    inmediato : out std_logic_vector (31 downto 0)
  );
end Valor_inmediato;

architecture arch of Valor_inmediato is

  begin 
  with sel select
    inmediato <= (31 downto 11 => instr (31)) & instr (30 downto 20)                                                                when "001",  -- tipo I
                 (31 downto 11 => instr (31)) & instr (30 downto 25) & instr (11 downto 7)                                          when "010",  -- tipo S
                 (31 downto 12 => instr (31))& instr (7) & instr (30 downto 25) & instr (11 downto 8)& "0"                          when "011",  -- tipo B
                 instr (31 downto 20) & instr (19 downto 12)& (11 downto 0 => '0')                                                   when "100",  -- tipo U
                 (31 downto 20 => instr (31)) & instr (19 downto 12) & instr (20) & instr (30 downto 25) & instr (24 downto 21)& "0" when "101",  -- tipo J
                 x"00000000" when others;

      end arch;
