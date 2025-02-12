library IEEE;
use IEEE.std_logic_1164.all;

entity MEF_control is
  port (
    reset, hab_pc, clk : in  std_logic;
    op : in  std_logic_vector (6 downto 0);
    esc_pc, branch, sel_dir, esc_mem, esc_instr, esc_reg : out std_logic;
    sel_inmediato : out std_logic_vector (2 downto 0);
    modo_alu, sel_op1, sel_op2, sel_y : out std_logic_vector (1 downto 0)
  );
end MEF_control; 

architecture arch of MEF_control is
  type estado_t is (
        ESPERA,       -- Espera que la RAM Lea la instrucción a cargar
        CARGA,        -- Carga una instrucción y avanta el PC
        DECODIFICA,   -- Carga los valores de R51, 112.
        EJECUTA,      -- Realiza un calculo| Carga RS2 en memoria| Lee dato de memoria
        ALMACENA      -- Almacena un resultado en RD o el destino de un branch en PC
                  
                  );

signal estado    : estado_t:= ESPERA; 
signal estado_sig: estado_t:= ESPERA;

begin
  
   -- Proceso secuencial para la memoria de estados

    mem_estado: process (clk)
      begin
       if rising_edge(clk) then
          if reset = '1' then
	            estado <= espera;
          else
	        estado <= estado_sig;
          end if;
        end if;

    end process;
    

    L_E_S: process (all)

    begin

      case (estado) is
        when ESPERA => estado_sig <= CARGA; 
        when CARGA => estado_sig<= DECODIFICA;
        when DECODIFICA => estado_sig <= EJECUTA;
        when EJECUTA => estado_sig <= ALMACENA;
        when ALMACENA => estado_sig <= ESPERA when hab_pc else CARGA;
      end case;
  
    end process;


    L_S: process (all)
    begin
        --Valores defecto рос
      esc_pc <= '0';
      branch <= '0';
      esc_mem <= '0';
      sel_dir <= '0';
      esc_instr <= '0'; 
      esc_reg <= '0';
      sel_inmediato <= "000";
      modo_alu <= "00"; 
      sel_op1 <= "00"; 
      sel_op2 <= "00"; 
      sel_y <= "01";

      case (estado) is
        when ESPERA => 
          --dat_lectura* <= mem(PC)
        when CARGA => 
          --instr* <= dat_lectura 
          --pc_instr <= PC
          esc_instr <= '1';
          -- PC* <= PC+4
          sel_op1 <= "00"; -- PC 
          sel_op2 <= "10"; -- 4 
          modo_alu <= "00"; -- Suma 
          sel_Y <= "01"; -- Y <= Y_alu 
          esc_pc <= '1'; -- PC* <= Y 
        when DECODIFICA =>
          --Carga RSI y RS2
        When EJECUTA =>     
          case (op) is
            when 7x"03" => 
             --dat_lectura* <= mem (RS1 + inmediato)
              sel_inmediato <= "001";
              sel_op1  <= "10";
              sel_op2  <= "01";
              modo_alu <= "00";
              sel_y    <= "01";
              sel_dir  <= '1';
            
            when 7x"13" =>
              --Y_alur_r* <=  <op_alu> (RS1, inmediato)
              sel_inmediato <= "001";
              sel_op1  <= "10"; 
              sel_op2  <= "01";
              modo_alu <= "01";

            when 7x"17" =>
              -- tipo U
              sel_INMEDIATO <= "100" ;
              -- alu : suma
               modo_alu <= "00";
               -- op1: pc
               sel_op1 <= "01";
               -- op2: inmediato
               sel_op2 <= "01";

            

            When 7x"23" =>
              --mem (RS1 + inmediato)* <= RS2
              sel_inmediato <= "010";
              sel_op1  <= "10";
              sel_op2  <= "01";
              modo_alu <= "00";
              sel_Y    <= "01"; 
              sel_dir  <= '1';
              esc_mem  <= '1';

            when 7x"33" =>
              --Y_alu_r* <= <op_alu>(RS1, RS2)
              sel_op1 <= "10"; 
              sel_op2 <= "00"; 
              modo_alu <= "10" ;

            when 7x"37" =>
              -- tipo U
              sel_INMEDIATO <= "100" ;
              -- alu : suma
               modo_alu <= "00";
               -- op1: 0
               sel_op1 <= "11";
               -- op2: inmediato
               sel_op2 <= "01";

            when 7x"63" =>
              --Y_alu_r* <= pc_instr + inmediato 
              sel_inmediato <= "011"; 
              sel_op1 <="01"; 
              sel_op2 <="01";
              
            when 7x"67" =>
              -- PC* <= RS1 + inmediato 
              sel_inmediato <= "001"; 
              sel_op1 <= "10"; 
              sel_op2 <= "01";
              modo_alu <= "00"; 
              sel_y <= "01";
              esc_pc <='1';
      
            when 7x"6F" =>
              --PC* <= pc_instr + inmediato 
              sel_inmediato <= "101";
              sel_op1 <= "01";
              sel_op2 <= "01";
              sel_y  <= "01";
              esc_pc <= '1';
      
            when others =>
              --no hace nada 
          end case;  --(op)
        when ALMACENA => 
          case (op) is
          
            when 7x"03"=>
              --RP <= dat_lectura
              sel_Y <= "00"; 
              esc_reg <= '1'; 
            
            when 7x"13" | 7x"33" =>
              --RD2* <= y_alu_r 
              sel_y <= "10"; 
              esc_reg <= '1';

            when 7x"23" =>
              -- dat_lectura* <= mem(PC)
      
            when 7x"63" =>
              -- Z <= <comp> (RS1,RS2)?= 0
              sel_op1 <= "10"; 
              sel_op2 <= "00"; 
              modo_alu <= "11";     
              -- si Z=Z_branch: PC* <= Y_alu_r
              sel_Y <= "10";
              branch <= '1';
      
            when 7x"67" | 7x"6F" =>
              -- RO* <= pc_instr+4
              sel_op1 <= "01";
              sel_op2 <= "10";
              modo_alu <= "00";
              sel_y <= "01";
              esc_reg <= '1'; 
            when others => 
              --no hace nada 
          end case; -- (op)
    
        when others =>
            --no hare hoda / no debiera ocurrir
      end case; --(estado)
  
  
    end process;
  
end arch;