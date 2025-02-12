library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_CPU is
end sim_CPU;

architecture sim of sim_CPU is
  component CPU is
    port (
      reset : in  std_logic;
      clk : in  std_logic;
      dat_lectura : in  std_logic_vector (31 downto 0);
      dir : out std_logic_vector (31 downto 2);
      dat_escritura : out std_logic_vector (31 downto 0);
      hab_escritura : out std_logic
    );
  end component; -- CPU

  Component Memoria_RAM_dp_256x32_B is
    generic (constant archivo: string:="");
    port (
      clk_escritura :in std_logic;
      dir_escritura :in std_logic_vector (7 downto 0); 
      hab_escritura :in std_logic_vector (3 downto 0);
      dat_escritura :in std_logic_vector (31 downto 0);
      clk_lectura   :in std_logic;
      dir_lectura   :in std_logic_vector(7 downto 0);
      hab_lectura   :in std_logic;
      dat_lectura  :out std_logic_vector (31 downto 0)
    );
  end component;
    
    signal reset: std_logic;
    signal clk  : std_logic;
    signal dat_lectura: std_logic_vector (31 downto 0);
    signal dir: std_logic_vector (31 downto 2);
    signal dat_escritura: std_logic_vector (31 downto 0);
    signal hab_escritura: std_logic;
    signal hab_escritura_mem: std_logic_vector(3 downto 0);
  begin
  

    dut: cpu port map(
      reset         => reset,
      clk           => clk,
      dat_lectura   => dat_lectura,
      dir           => dir,
      dat_escritura => dat_escritura,
      hab_escritura => hab_escritura

    );
    
    hab_escritura_mem <= (others=>hab_escritura);
    
    memoria: Memoria_RAM_dp_256x32_B generic map ( archivo => "../src/prog_prueba.mem") port map (
      clk_escritura => clk,
      dir_escritura => dir (9 downto 2), 
      hab_escritura => hab_escritura_mem,
      dat_escritura => dat_escritura,
      clk_lectura   => clk,
      dir_lectura   => dir (9 downto 2),
      hab_lectura   => '1',
      dat_lectura   => dat_lectura
    );
    
    reloj : process
      begin
      clk <= '0';
      wait for 1 ns;
      clk <= '1';
      wait for 1 ns;
    end process;
    
    estimulo: process
      procedure espera_ciclo is
      begin 
        wait until rising_edge(clk);
        wait for 0.5 ns;
      end procedure; 
    begin
      reset <= '1';
      espera_ciclo;
      reset <= '0';
      for i in 0 to 199 loop 
        espera_ciclo; 
      end loop; 
      finish;
    end process;
end sim;
