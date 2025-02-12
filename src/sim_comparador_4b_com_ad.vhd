library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_comparador_4b_com_ad is
end sim_comparador_4b_com_ad;

architecture sim of sim_comparador_4b_com_ad is
  component comparador_4b_com_ad is
    port (
      A : in  std_logic_vector (3 downto 0);
      B : in  std_logic_vector (3 downto 0);
      mayor : out std_logic;
      menor : out std_logic;
      igual : out std_logic
    );
  end component; -- comparador_4b_binnat
  signal entradas : std_logic_vector (7 downto 0);
  signal mayor, menor, igual: std_logic;
begin
  -- Dispositivo bajo prueba
  dut : comparador_4b_com_ad port map (A=>entradas(7 downto 4),B=>entradas(3 downto 0),
  mayor=>mayor,menor=>menor,igual=>igual);

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
