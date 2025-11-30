library ieee;
use ieee.std_logic_1164.all;

entity controle is 
port(clock: in std_logic;
     reset, enter: in std_logic;
     end_time, end_round, end_game: in std_logic; -- status
     R1, E1, E2, E3, E4, E5, E6: out std_logic -- sinais controle datapath
     );
end controle;

architecture bhv of controle is

type STATES is (Init, Setup, Play_FPGA, Play_user, Next_round, Check, Espera, Result);
signal EA, PE: STATES;

begin

    -- Atualiza o estado
    P1: process(clock, reset)
        begin
         if reset= '0' then
            EA <= E0;
         elsif clock'event and clock= '0' then
            EA <= PE;
         end if;
        end process;
    
    -- Comportamento do próximo estado    
    P2: process(EA, enter, end_time, end_round, end_game)
        begin
         case EA is
         
         when Init =>
             R1 <= '1' ;
             PE <= Setup;
             
         when Setup =>
            if enter = '1' then
                prox_estado <= Play_FPGA;
            end if;
            E1 <= '1';  -- escreve nível

         when Play_FPGA =>
            if enter = '1' then
                prox_estado <= Play_user;
            end if;
            E2 <= '1';  -- registra tempo FPGA
            
         when Play_user =>
            if end_time = '1' then
                prox_estado <= Result;
            elsif enter = '1' then
                prox_estado <= Next_round;
            end if;
            E2 <= '1';  -- ativa tempo

         when Next_round =>
            prox_estado <= Check;
            E4 <= '1';  -- incrementa rodada

         when Check =>
            if end_game = '1' or end_round = '1' then
                prox_estado <= Result;
            else
                prox_estado <= Espera;
            end if;
            E3 <= '1';  -- compara
            E5 <= '1';  -- penaliza

         when Espera =>
            if enter = '1' then
                prox_estado <= Play_FPGA;
            end if;
            E6 <= '1';  -- mostra estimativa

         when Result =>
            if enter = '1' then
                prox_estado <= Init;
            end if;
            E6 <= '1';  -- mostra ponto
         end case;
        end process;
end bhv;
