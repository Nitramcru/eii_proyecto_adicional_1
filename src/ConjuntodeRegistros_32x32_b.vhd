library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ConjuntodeRegistros_32x32_b is
  port (clk,hab_escritura: in std_logic;
        dir_escritura, dir_lectura_1 ,dir_lectura_2 :in std_logic_vector (4 downto 0);
        dat_escritura :in std_logic_vector (31 downto 0);
        dat_lectura_1, dat_lectura_2 :out std_logic_vector (31 downto 0)
       );
end ConjuntodeRegistros_32x32_b;


architecture arch of ConjuntodeRegistros_32x32_b is
  type mem_t is array (0 to 31) of std_logic_vector ( 31 downto 0 );
  signal mem: mem_t := (others => x"00000000");
  begin
    
    puertos: process (clk)
    begin
      if rising_edge (clk) then
        if hab_escritura ='1' and dir_escritura /= "00000" then 
           mem(to_integer (unsigned(dir_escritura))) <= dat_escritura;
        end if;

            dat_lectura_1 <= mem(to_integer (unsigned (dir_lectura_1)));
            dat_lectura_2 <= mem(to_integer (unsigned (dir_lectura_2)));
            
      end if;
    end process;
  end arch; 