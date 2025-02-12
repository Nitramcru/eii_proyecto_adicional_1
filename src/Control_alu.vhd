library IEEE;
use IEEE.std_logic_1164.all;

entity Control_alu is
  port (
    funct3   : in  std_logic_vector (2 downto 0);
    funct7_5 : in  std_logic;
    modo     : in  std_logic_vector (1 downto 0);
    fn_alu   : out std_logic_vector (3 downto 0)
  );
end Control_alu;

architecture arch of Control_alu is
  begin
    selector: process (all)
    begin
      case (modo) is
      when "01" =>  -- operacion con valor inmediato (addi,..., andi)
      fn_alu(3 downto 1) <= funct3;
      fn_alu(0) <= (funct3 ?= "101") AND funct7_5;
      when "10" => -- Operacion entre registros (add,..., and)
      fn_alu <= funct3 & funct7_5;
      when "11" => -- condicion de salto (beq,..., bgev)
      fn_alu <= "0" & funct3(2 downto 1 ) & "1";
      when others => -- "00" suma siempre
      fn_alu <= "0000";

      end case;
    end process;
end arch;