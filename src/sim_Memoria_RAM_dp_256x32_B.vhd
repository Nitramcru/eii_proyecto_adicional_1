library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_Memoria_RAM_dp_256x32_B is
end sim_Memoria_RAM_dp_256x32_B;

architecture sim of sim_Memoria_RAM_dp_256x32_B is
  component Memoria_RAM_dp_256x32_B is
    port (
      clk_escritura, clk_lectura :in std_logic;
      hab_lectura :in std_logic;
      hab_escritura :in std_logic_vector (3 downto 0);
      dir_lectura, dir_escritura :in std_logic_vector (6 downto 0);
      dat_escritura :in std_logic_vector (31 downto 0);
      dat_lectura :out std_logic_vector (31 downto 0)
    );
  end component; -- Memoria_RAM_dp_256x32_B
  
  
  signal entradas : std_logic_vector (1 downto 0);
  signal salida : std_logic;
begin
 
 
 
  -- Dispositivo bajo prueba
  dut : Memoria_RAM_dp_256x32_B port map (A=>entradas(1),B=>entradas(0),Y=>salida);

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
