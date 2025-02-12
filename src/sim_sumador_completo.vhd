library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_sumador_completo is
end sim_sumador_completo;

architecture sim of sim_sumador_completo is
  component sumador_completo is
    port (
      A : in  std_logic;
      B : in  std_logic;
      Ci: in  std_logic;
      Co: in  std_logic;
      Y : out std_logic
    );
  end component; -- sumador_completo
  signal entradas : std_logic_vector (2 downto 0);
  signal suma : std_logic;
  signal acarreo : std_logic;
begin
  -- Dispositivo bajo prueba
  dut : sumador_completo port map (
    A=>entradas(2),
    B=>entradas(1),
    Ci=>entradas (0),
    Y=>suma,
    Co=>acarreo);
  
  excitaciones: process
  begin
    for i in 0 to 7 loop
      entradas <= std_logic_vector(to_unsigned(i,3));
      wait for 1 ns;
    end loop;
    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;