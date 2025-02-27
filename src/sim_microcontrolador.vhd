library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_microcontrolador is
end sim_microcontrolador;

architecture sim of sim_microcontrolador is
  component microcontrolador is
    generic(
    constant archivo : string :="parpadeo_con_retardo.mem"
  );

  port (
    reset : in std_logic;
    clk : in std_logic;
    I0, I1, I2, I3 : in std_logic;
    O0, O1, O2, O3 : out std_logic
  );
  end component; -- microcontrolador

  signal reset, clk : std_logic := '0';
  signal I0, I1, I2, I3 : std_logic := '0';
  signal O0, O1, O2, O3 : std_logic;

  constant clk_period : time := 10 ns; -- Define el periodo del reloj


begin
  -- Dispositivo bajo prueba
  dut : microcontrolador  (A=>entradas(1),B=>entradas(0),Y=>salida);

  dut: microcontrolador port map (archivo => "parpadeo_con_retardo.mem") 
  port map (
    reset => reset,
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

 
  process
  begin
    -- Reset inicial
    reset <= '1';
    wait for 20 ns;
    reset <= '0';

    
  excitaciones: process
  begin
    for i in 0 to 15 loop
      (I0, I1, I2, I3) <= std_logic_vector(to_unsigned(i, 4));
      wait for clk_period;
    end loop;

    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
