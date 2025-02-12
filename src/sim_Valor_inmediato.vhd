library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_Valor_inmediato is
end sim_Valor_inmediato;

architecture sim of sim_Valor_inmediato is
  component Valor_inmediato is
    port (
      A : in  std_logic;
      B : in  std_logic;
      Y : out std_logic
    );
  end component; -- Valor_inmediato
  signal entradas : std_logic_vector (1 downto 0);
  signal salida : std_logic;
begin
  -- Dispositivo bajo prueba
  dut : Valor_inmediato port map (A=>entradas(1),B=>entradas(0),Y=>salida);

  excitaciones: process
  begin
    for i in 0 to (2**entradas'length)-1 loop
      entradas <= std_logic_vector(to_unsigned(i,entradas'length));
      wait for 1 ns;
    end loop;
    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
