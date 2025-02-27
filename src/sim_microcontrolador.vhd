library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_microcontrolador is
end sim_microcontrolador;

architecture sim of sim_microcontrolador is
  component microcontrolador is
    generic(
    constant archivo : string :="../src/parpadeo_con_retardo.mem"
  );

  port (
    nreset : in std_logic;
    clk : in std_logic;
    I0, I1, I2, I3 : in std_logic;
    O0, O1, O2, O3 : out std_logic
  );
  end component; -- microcontrolador

  signal nreset, clk : std_logic := '0';
  signal I0, I1, I2, I3 : std_logic := '0';
  signal O0, O1, O2, O3 : std_logic;

  constant clk_period : time := 10 ns; -- Define el periodo del reloj


begin
  -- Dispositivo bajo prueba
  

  dut: microcontrolador generic map (archivo => "../src/parpadeo_sin_retardo.mem") 
  port map (
    nreset => nreset,
    clk => clk,
    I0 => I0, I1 => I1, I2 => I2, I3 => I3,
    O0 => O0, O1 => O1, O2 => O2, O3 => O3
  );

  
  process
  begin
    while true loop
      clk <= '0';
      wait for clk_period / 2;
      clk <= '1';
      wait for clk_period / 2;
    end loop;
  end process;

 
  excitaciones: process
  begin
    I0 <= '0';
    I1 <= '0';
    I2 <= '0';
    I3 <= '0';
    nreset <= '0';
    wait for clk_period;
    nreset <= '1';

    wait for 1000*clk_period;

    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
