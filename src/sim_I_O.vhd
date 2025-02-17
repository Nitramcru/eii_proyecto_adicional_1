library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use std.env.finish;

entity sim_I_O is
end sim_I_O;

architecture sim of sim_I_O is
  component I_O is
    port (
      
    clk :in std_logic;
    dir:in std_logic_vector (2 downto 0);
    hab_escritura :in std_logic;
    dat_escritura :in std_logic_vector (31 downto 0);
   
    
    dat_lectura :out std_logic_vector (31 downto 0);

    I0 :in std_logic;
    I1 :in std_logic;
    I2 :in std_logic;
    I3 :in std_logic;

    O0 :out std_logic;
    O1 :out std_logic;
    O2 :out std_logic;
    O3 :out std_logic
    );
  end component; -- I_O


  signal clk : std_logic;
  signal dir : std_logic_vector (2 downto 0);
  signal hab_escritura : std_logic;
  signal dat_escritura : std_logic_vector (31 downto 0);
  signal dat_lectura : std_logic_vector (31 downto 0);
  signal I0 : std_logic;
  signal I1 : std_logic;
  signal I2 : std_logic;
  signal I3 : std_logic;
  signal O0 : std_logic;
  signal O1 : std_logic;
  signal O2 : std_logic;
  signal O3 : std_logic;

begin
  -- Dispositivo bajo prueba
  dut : I_O port map (
    clk => clk,
    dir => dir,
    hab_escritura => hab_escritura,
    dat_escritura => dat_escritura,
    dat_lectura => dat_lectura,
    I0 => I0,
    I1 => I1,
    I2 => I2,
    I3 => I3,
    O0 => O0,
    O1 => O1,
    O2 => O2,
    O3 => O3
  );

  reloj : process
  begin
    clk <= '0';
    wait for 1 ns;
    clk <= '1';
    wait for 1 ns;
  end process;

  excitaciones: process
    procedure sig_ciclo is
    begin
      wait until rising_edge (clk);
      wait for 0.5 ns;
    end procedure;
  begin
    dir <= "000";
    hab_escritura <= '0';
    dat_escritura  <= 32x"0";
    
    I0 <= '0';
    I1 <= '0';
    I2 <= '0';
    I3 <= '0';

    -- lee entrada 0
    sig_ciclo;
    sig_ciclo;
    
    -- lee denuevo entrada 0 (que cambia valor)
    I0 <= '1';
    sig_ciclo;
    sig_ciclo;

    -- lee salida O0
    dir <= "100";
    sig_ciclo;

    -- escribe 0 en salida O0
    hab_escritura <= '1';
    dat_escritura  <= 32x"0";
    sig_ciclo;
    -- escribe 1 en salida O0
    dat_escritura  <= 32x"1";
    sig_ciclo;
    -- deja de escribir
    hab_escritura <= '0';
    dat_escritura  <= 32x"0";
    sig_ciclo;

    wait for 1 ns; -- Espera extra antes de salir
    finish;
  end process; -- excitaciones
end sim;
