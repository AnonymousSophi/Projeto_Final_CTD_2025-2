library ieee;
use ieee.std_logic_1164.all;

entity controle is 
port(clock: in std_logic;
     reset, enter: in std_logic;
     end_time, end_round, end_game, end_FPGA: in std_logic; -- status
     R1, R2, E1, E2, E3, E4, E5: out std_logic -- sinais controle datapath
     );
end controle;

architecture bhv of controle is

type STATES is (Init, Setup, Play_FPGA, Play_user, Count_round, Check, Espera, Result);
signal EA, PE: STATES;

begin

    -- Atualiza o estado
    P1: process(clock, reset)
        begin
         if reset= '0' then
            EA <= Init;
         elsif clock'event and clock= '0' then
            EA <= PE;
         end if;
        end process;
    
    -- Comportamento do próximo estado    
    P2: process(EA, enter, end_time, end_round, end_game)
        begin
         case EA is
         
         when Init =>
            if enter = '1' then
                PE <= Setup;
            else
                PE <= Init;
            end if;
            R1 <= '1';  -- Reset contadores
             
         when Setup =>
            if enter = '1' then
                PE <= Play_FPGA;
            end if;
            R2 <= '1';  -- Config. inicial

         when Play_FPGA =>
            if end_FPGA = '1' then
                PE <= Play_user;
            end if;
            E1 <= '1';  -- registra tempo FPGA
            
         when Play_user =>
            if end_time = '1' then
                PE <= Result;
            elsif enter = '1' then
                PE <= Count_round;
            else
                PE <= Play_user;
            end if;
            E1 <= '1';  -- ativa counter_time

         when Count_round =>
            PE <= Check;
            E2 <= '1';  -- incrementa rodada

         when Check =>
            if end_game = '1' then      -- Máx erros
                PE <= Result;
            elsif end_round = '1' then  -- Máx rodadas
                PE <= Result;
            else
                PE <= Espera;           -- Próx rodada
            end if;
            E4 <= '1';  -- Verifica condições 

         when Espera =>
            if enter = '1' then
                PE <= Play_FPGA;
            end if;
            E5 <= '1';  -- mostra estimativa

         when Result =>
            if enter = '1' then
                PE <= Init;
            end if;
            E6 <= '1';  -- mostra ponto
         end case;
        end process;
end bhv;
