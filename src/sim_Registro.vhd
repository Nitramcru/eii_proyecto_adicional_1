library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;
use work.util_sim.all;

entity sim_Registro is
end sim_Registro;

architecture sim of sim_Registro is
  component Registro is
    port (
      clk : in  std_logic;
      D : in  std_logic_vector (31 downto 0);
      had : in std_logic;
      Q : out std_logic_vector (31 downto 0)
    );
  end component; -- Registro

  signal clk,hab : std_logic;
  signal D,Q : std_logic_vector (31 downto 0);
begin

  -- Dispositivo bajo prueba
  dut : Registro port map (clk=>clk,D=>D,hab=>hab,Q=>Q);

  reloj: process
  begin
    clk<= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
  end process;

  estimulo: process
    variable aleatorio:aleatorio_t;
    procedure sig_ciclo is
    begin
      wait until rising_edge (clk);
      wait for 0.5 ns;
    end procedure;


  begin
    for i in 0 to 99 loop
      D <= aleatorio.genera_vector(32);
      hab<= aleatorio.genera_bit;
      sig_ciclo;
    end loop;
    wait for 1 ns; 
    finish;
  end process; 
end sim;
