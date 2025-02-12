library IEEE;
use IEEE.std_logic_1164.all;

entity ALU is
  port (
    A, B : in  std_logic_vector (31 downto 0);
    Sel  : in  std_logic_vector (3 downto 0);
    Y    : out std_logic_vector (31 downto 0);
    Z    : out std_logic
  );
end ALU;

architecture arch of ALU is
  
  Component Funcion_SUMA_RESTA is
    port (
      entrada1 : in  std_logic_vector (31 downto 0);
      entrada2 : in  std_logic_vector (31 downto 0);
      Seleccion  : in  std_logic;
      salida  : out  std_logic_vector (31 downto 0)
    );
  
  end component;

  Component Funcion_desplaza_izq is
    port (
      A         : in  std_logic_vector (31 downto 0);
      B         : in  std_logic_vector (4 downto 0);
      Y         : out std_logic_vector (31 downto 0)
    
    );
  end component;
  
  Component Funcion_Menor is
    port (
      entradaA   : in  std_logic_vector (31 downto 0);
      entradaB   : in  std_logic_vector (31 downto 0);
      Seleccion  : in  std_logic;
      
      salida     : out std_logic
  
    );
  
  end component;


  Component Funcion_desplaza_der is
  port (
    A         : in  std_logic_vector (31 downto 0);
    B         : in  std_logic_vector (4 downto 0);
    con_signo : in std_logic;
    Y         : out std_logic_vector (31 downto 0)
  );
  end component;

  Component FuncionXOR is
    port (
      entrada1 : in  std_logic_vector (31 downto 0);
      entrada2 : in  std_logic_vector (31 downto 0);
      salida   : out  std_logic_vector (31 downto 0)
    );
  end component;

  Component FuncionOR is
    port (
      entrada1 : in  std_logic_vector (31 downto 0);
      entrada2 : in  std_logic_vector (31 downto 0);
      salida  : out  std_logic_vector (31 downto 0)
  
    );
  end component;

  component FuncionAND is
    port (
      entrada1 : in  std_logic_vector (31 downto 0);
      entrada2 : in  std_logic_vector (31 downto 0);
      salida  : out  std_logic_vector (31 downto 0)
    );
  end component;

  component FuncionCero is
    port (
      entrada : in  std_logic_vector (31 downto 0);
      salida  : out std_logic
    );
  end component;

  
    signal y_and, y_or, y_xor, y_suma_resta: std_logic_vector (31 downto 0);
    signal y_menor, y_desp_izq, y_desp_der, y_Sel: std_logic_vector (31 downto 0);
    signal resta, menor_con_signo, desp_con_signo: std_logic;
    
begin
  
  U1: Funcion_SUMA_RESTA port map (entrada1 => A, entrada2 => B, Seleccion => Resta, salida=>Y_suma_resta);
  
  U2: Funcion_desplaza_izq port map   (A=>A, B=>B(4 downto 0), Y=>Y_desp_izq );
  
  U3: Funcion_Menor port map      (entradaA=>A, entradaB=>B, seleccion => menor_con_signo, salida=>Y_menor(0));
  Y_menor(31 downto 1)<=31x"0";
  
  U4: Funcion_desplaza_der port map   (A=>A, B=>B (4 downto 0), con_signo=> desp_con_signo, Y => Y_desp_der);

  U5: FuncionXOR port map (entrada1=>A, entrada2=>B, salida => Y_xor); 

  U6: FuncionOR port map (entrada1=>A, entrada2=>B, salida => Y_or); 

  U7: FuncionAND port map (entrada1=>A, entrada2=>B, salida => Y_and);

  with sel select
  y_sel <= y_suma_resta when "0000" | "0001",
           y_desp_izq   when "0010" | "0011",
           y_menor      when "0100" | "0101" | "0110" | "0111",
           y_desp_der   when "1010" | "1011",
	         y_xor        when "1000" | "1001",
	         y_or         when "1100" | "1101",	
           y_and        when others; -- 1110 1111	

  Y <= y_sel;

  U8: FuncionCero port map (entrada=> Y_sel, salida=>z);
      resta <= sel (0) ;
      menor_con_signo <= not sel (1);
      desp_con_signo <= sel (0);

 

end arch;
