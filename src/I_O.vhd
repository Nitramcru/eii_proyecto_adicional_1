library IEEE;
use IEEE.std_logic_1164.all;

entity I_O is
  port (
    clk :in std_logic;
    dir:in std_logic_vector (7 downto 0);
    hab_escritura :in std_logic_vector (3 downto 0);
    dat_escritura :in std_logic_vector (31 downto 0);
   
    
    dat_lectura :out std_logic_vector (31 downto 0)

    I0 :in std_logic;
    I1 :in std_logic;
    I2 :in std_logic;
    I3 :in std_logic;

    O0 :out std_logic;
    O1 :out std_logic;
    O2 :out std_logic;
    O3 :out std_logic;
  );
end I_O;

architecture arch of I_O is
  component ffd is
    port (
      D : in  std_logic;
      hab : in  std_logic:='1';
      clk : in  std_logic;
      Q : out std_logic
    );
  end component;


  signal CI0,CI1,CI2,CI3, DI0,DI1,DI2,DI3, se, D00,D01,D10,D11 :std_logic;
  signal k: std_logic_vector (2 downto 0);
begin
  

  U1: ffd port map (D => I0, D =>Q , clk =>clk);
  U2: ffd port map (D => I1, D =>Q , clk =>clk);
  U3: ffd port map (D => I2, D =>Q , clk =>clk);
  U4: ffd port map (D => I3, D =>Q , clk =>clk);

  U9: 

end arch;
