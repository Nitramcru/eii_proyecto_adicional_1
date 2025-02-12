library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.util_sim.all;
use std.env.finish;

entity sim_ALU is
end sim_ALU;

architecture sim of sim_ALU is
  component ALU is
    port (
      A, B : in  std_logic_vector (31 downto 0);
      Sel : in  std_logic_vector (3 downto 0);
      Y : out std_logic_vector (31 downto 0);
      Z : out std_logic
    );
  end component; -- ALU


  signal A_tb, B_tb : std_logic_vector (31 downto 0);
  signal Sel_tb     : std_logic_vector (3 downto 0);
  signal Y_tb       : std_logic_vector (31 downto 0);
  signal Z_tb       : std_logic;

begin
  -- Dispositivo bajo prueba
  dut : ALU
  port map (
    A   => A_tb,
    B   => B_tb,
    Sel => Sel_tb,
    Y   => Y_tb,
    Z   => Z_tb
  );

  
  excitaciones: process

  variable aleatorio : aleatorio_t;
  
  begin

    -- Caso 1: Suma de dos números
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "0000" ;
    wait for 1 ns;

    -- Caso 2: Resta de dos números
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "0001" ;
    wait for 1 ns;
    
    -- Caso 3: Desplazamiento a la izquierda
    A_tb <= 32x"1";
    B_tb <= aleatorio.genera_vector_en_rango(0,31, 32) ; 

    Sel_tb <= "0010" ;
    wait for 1 ns;
    Sel_tb <= "0011" ;
    wait for 1 ns;
    
    -- Caso 4: Menor entre A y B (tiene signo)
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "0100" ;
    wait for 1 ns;
    Sel_tb <= "0101" ;
    wait for 1 ns;

    -- Caso 5: Menor entre A y B (no tiene signo)
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "0110" ;
    wait for 1 ns;
    Sel_tb <= "0111" ;
    wait for 1 ns;

    -- Caso 6: Desplazamiento a la derecha (sin extension de signo)
    A_tb <= 32x"80000000" ; 
    B_tb <= aleatorio.genera_vector_en_rango(0,31, 32) ; 

    Sel_tb <= "1010" ;
    wait for 1 ns;
    -- Caso 7: Desplazamiento a la derecha (con extension de signo)

    Sel_tb <= "1011" ;
    wait for 1 ns;

  
    -- Caso 8: XOR entre A y B
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "1000" ;
    wait for 1 ns;
    Sel_tb <= "1001" ;
    wait for 1 ns;

    -- Caso 9: OR entre A y B
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "1100" ;
    wait for 1 ns;
    Sel_tb <= "1101" ;
    wait for 1 ns;

    -- Caso 10: AND entre A y B
    A_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 
    B_tb <= aleatorio.genera_vector_en_rango(-100,100, 32) ; 

    Sel_tb <= "1111" ;
    wait for 1 ns;
    Sel_tb <= "1110" ;
    wait for 1 ns;    
    finish;

  end process; -- excitaciones
end sim;
