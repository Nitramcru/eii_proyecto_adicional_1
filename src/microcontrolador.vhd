library IEEE;
use IEEE.std_logic_1164.all;

entity microcontrolador is
  generic(
    constant archivo : string :="parpadeo_con_retardo.mem"
  );
  port (
    reset :in std_logic;
    clk :in std_logic;

    I0 :in std_logic;
    I1 :in std_logic;
    I2 :in std_logic;
    I3 :in std_logic;

    O0 :out std_logic;
    O1 :out std_logic;
    O2 :out std_logic;
    O3 :out std_logic

  );
end microcontrolador;

architecture arch of microcontrolador is
  
  component CPU is
    port (
      reset: in std_logic;
      clk  : in std_logic;
      dat_lectura : in std_logic_vector (31 downto 0);
      dir: out std_logic_vector (31 downto 2);
      dat_escritura : out std_logic_vector (31 downto 0);
      hab_escritura: out std_logic
    );
  end component;

  component Memoria_RAM_dp_256x32_B is
    generic(
     constant archivo : string :=""
          );
  
    port (
      clk_escritura :in std_logic;
      dir_escritura :in std_logic_vector (7 downto 0);
      hab_escritura :in std_logic_vector (3 downto 0);
      dat_escritura :in std_logic_vector (31 downto 0);
     
      clk_lectura :in std_logic;
      dir_lectura :in std_logic_vector (7 downto 0);
      hab_lectura :in std_logic;
      dat_lectura :out std_logic_vector (31 downto 0)
    );
  
  end component;

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
  end component;

  component ffd is
    port (
      D : in  std_logic;
      hab : in  std_logic:='1';
      clk : in  std_logic;
      Q : out std_logic
    );
  end component;

  signal hab_escritura, hab_escritura_RAM, hab_escritura_I_O, sel_I_O :std_logic;
  signal dir, dat_escritura, dat_lectura :std_logic_vector (31 downto 0);

begin


  U1: CPU port map (
    reset => reset ,
    clk  => clk ,
    dat_lectura => dat_lectura,
    dir => dir,
    dat_escritura => dat_escritura,
    hab_escritura => hab_escritura
  );

  U2: Memoria_RAM_dp_256x32_B  generic map (
    archivo => archivo
   ) port map (
      clk_escritura => clk,
      dir_escritura => dir (9 downto 2),
      hab_escritura => (others => hab_escritura_RAM ) ,
      dat_escritura => dat_escritura,
     
      clk_lectura => clk,
      dir_lectura => dir,
      hab_lectura => '1',
      dat_lectura => dat_lectura
  );

  hab_escritura <= not dir(31) and hab_escritura;


  U3: I_O port map (
        clk => clk ,
        dir => dir (4 downto 2),
        hab_escritura => hab_escritura_I_O ,
        dat_escritura => dat_escritura ,
        dat_lectura => '1',

        I0 => I0 ,
        I1 => I1,
        I2 => I2,
        I3 => I3,

        O0 => O0,
        O1 => O1,
        O2 => O2,
        O3 => O3

  );

  hab_escritura_I_O <= dir(31) and hab_escritura;

  U4: ffd port map (
    
        D => dir (31),
        clk => clk,
        Q => sel_I_O

  );
  
  
end arch;
