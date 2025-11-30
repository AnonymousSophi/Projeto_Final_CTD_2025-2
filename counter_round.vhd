library ieee;
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; -- Contador (conta até 16)
use ieee.std_logic_arith.all; 

entity counter_round is
port(Enable, Reset, CLOCK: in std_logic;
	 Round: out std_logic_vector(3 downto 0);
	 end_round: out std_logic -- "tc"
	 );
end counter_round;

architecture bhv of counter_round is
    signal count: unsigned(3 downto 0) := (others => '0'); -- Contador interno como unsigned
    
begin

    -- Contagem
    process(CLOCK, Reset)
    begin
        -- Verifica o Reset (assíncrono)
        if Reset = '1' then
            count <= (others => '0');    -- Rst contador p/ 0
        elsif rising_edge(CLOCK) then
            if Enable = '1' then            -- Incrementa contador se Enable ativo
                if count = 16 then
                    count <= (others => '0'); -- Rst contador após 16
                else
                    count <= count + 1;       -- Incrementa contador
                end if;
            end if;
        end if;
    end process;

    Round <= std_logic_vector(count);

    -- Ativa sinal end_round p/ contador = 16
    end_round <= '1' when count = 16 else '0';

end bhv;
