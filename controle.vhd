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

-- CONFERIR SE A LÓGICA BATE!!
    
-- R1 => rst de tempo e de divisor de clk
-- R2 => rst de round, bônus e regs SEL/USER
-- E1 => habilita reg SEL e mostra nível/código em HEX(3..0) e ativa LED rounds quando for 0
-- E2 => habilita displays (entrada nas portas NOR do datapath)
-- E3 => habilita counter_time e reg USER, troca HEX5 e 4 para 't' e tempo
-- E4 => incrementa counter_round e REG_BONUS
-- E5 => HEX7 e 6 mostram RESULT em vez de ROM

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
    P2: process(EA, enter, end_time, end_round, end_game, end_FPGA)
        begin
    -- valores padrão (evita latch e "lixo" de estado anterior)
        R1 <= '0';
        R2 <= '0';
        E1 <= '0';
        E2 <= '0';
        E3 <= '0';
        E4 <= '0';
        E5 <= '0';
        PE <= EA;   -- default (fica no msm estado)
        
         case EA is
         
    -- INIT: reseta tudo e vai p/ SETUP
         when Init =>
            R1 <= '1';      -- reset tempo
            R2 <= '1';      -- reset round/bônus/SEL/USER
            PE <= Setup;    -- vai p/ escolha de nível/código
            
    -- SETUP: escolha de nível e código
         when Setup =>
            if enter = '1' then
                PE <= Play_FPGA;
            end if;
            R2 <= '1';  -- registradores zerados
            E1 <= '1';  -- mostra L/C, carrega SEL com SW(3..0)
            E2 <= '1';  -- habilita displays

    -- PLAY_FPGA: mostra sequência ROM em HEX(7..0)
         when Play_FPGA =>
            if end_FPGA = '1' then
                PE <= Play_user;
            end if;
            E2 <= '1';  -- liga todos HEX, E1=E3=E5=0 não trocam por L/C/t/RESULT
            
    -- PLAY_USER: usuário digita código, tempo regressivo em t/tempo
         when Play_user =>
            if end_time = '1' then
                PE <= Result;       -- máx tempo
            elsif enter = '1' then
                PE <= Count_round;  -- user mandou código
            end if;
            E3 <= '1';  -- habilita counter_time + REG_USER +  't'/tempo
            
    -- COUNT_ROUND: incrementa rodada, atualiza bônus
         when Count_round =>
            PE <= Check;
            E4 <= '1';  -- enable counter_round + REG_Bonus
            
    -- CHECK: verifica end_game / end_round
         when Check =>
            if (end_game = '1') or (end_round = '1') then
                PE <= Result;
            else
                PE <= Espera;
            end if;

    -- ESPERA: aguarda enter p/ próx. rodada
         when Espera =>
            if enter = '1' then
                PE <= Play_FPGA;
            end if;

    -- RESULT: mostra pontuação final
         when Result =>
            if enter = '1' then
                PE <= Init;     -- recomeça o jogo
            end if;
            E5 <= '1';  -- seleciona RESULT na MUX_HEX7/6
         end case;
        end process;
end bhv;
