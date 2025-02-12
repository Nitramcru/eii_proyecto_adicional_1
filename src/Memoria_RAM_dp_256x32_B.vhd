library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity Memoria_RAM_dp_256x32_B is
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

end Memoria_RAM_dp_256x32_B;

architecture arch of Memoria_RAM_dp_256x32_B is
  type mem_t is array (0 to 255) of std_logic_vector (31 downto 0);


  -- Función impura para inicializar la memoria
  impure function inicializa (archivo_n: string) return mem_t is
    file origen: text;
    variable linea: line;
    variable contenido: mem_t;

  begin 
    if archivo_n= "" then
      contenido:= (others => 32x"0");
    else
      file_open (origen, archivo, READ_MODE);
        for k in contenido'range loop
          exit when endfile (origen);
          readline(origen,linea);
          hread (linea, contenido(k));
        end loop;

      file_close (origen);

    end if;
    return contenido;
  end function;


  signal mem: mem_t:= inicializa (archivo);
begin
  
  puerto_lectura : process (clk_lectura)
  begin
    if rising_edge (clk_lectura) then
      if hab_lectura = '1' then
        dat_lectura <= mem (to_integer (unsigned(dir_lectura)));
      end if;
    end if;
  end process;

  puerto_escritura: process (clk_escritura)
      variable dir, pos :integer;
  begin
      if rising_edge (clk_escritura) then
        dir := to_integer (unsigned (dir_escritura));
        for k in 0 to 3 loop
          pos := k*8;
          if hab_escritura(k)= '1' then
            mem(dir) (pos+7 downto pos) <= dat_escritura (pos+7 downto pos);
          end if;
        end loop;
      end if;
  end process;
end arch;