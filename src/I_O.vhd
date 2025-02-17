library IEEE;
use IEEE.std_logic_1164.all;

entity I_O is
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
  

  U1: ffd port map (D => I0,  Q=>CI0 , clk =>clk);
  U3: ffd port map (D => I1,  Q=>CI1 , clk =>clk);
  U5: ffd port map (D => I2,  Q=>CI2 , clk =>clk);
  U7: ffd port map (D => I3,  Q=>CI3 , clk =>clk);

  U2: ffd port map (D => CI0, Q=>DI0 , clk =>clk);
  U4: ffd port map (D => CI1, Q=>DI1 , clk =>clk);
  U6: ffd port map (D => CI2, Q=>DI2 , clk =>clk);
  U8: ffd port map (D => CI3, Q=>DI3 , clk =>clk);

  U9: process(clk)
      begin
      if rising_edge(clk) then
          k <= dir;  
      end if;
      end process;

  U10: with k select dat_lectura(0) <=
    DI0 when "000",
    DI1 when "001",
    DI2 when "010",
    DI3 when "011",

    O0 when "100",
    O1 when "101",
    O2 when "110",
    O3 when others; --111

  dat_lectura(31 downto 1 ) <= 31x"0";

  U11: process(all)
      begin
        D00 <='0';
        D01 <='0';
        D10 <='0';
        D11 <='0';

        if (dir(2) and hab_escritura) then
          
        case( dir (1 downto 0) ) is
        
          when "00" => D00 <= '1'; 
          when "01" => D01 <= '1';
          when "10" => D10 <= '1';
          when others => D11 <= '1';
        
        end case ;
        end if ;
        
      end process;


  U12: ffd port map (D => dat_escritura(0) ,hab =>D00 , Q => O0, clk =>clk);

  U13: ffd port map (D => dat_escritura(0) ,hab =>D01 , Q => O1, clk =>clk);

  U14: ffd port map (D => dat_escritura(0) ,hab =>D10 , Q => O2, clk =>clk);

  U15: ffd port map (D => dat_escritura(0) ,hab =>D11 , Q => O3, clk =>clk);

end arch;
