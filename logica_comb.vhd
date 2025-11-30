library IEEE;
use IEEE.Std_Logic_1164.all;

entity logica_comb is
port(round, bonus: in std_logic_vector(3 downto 0);
	 nivel: in std_logic_vector(1 downto 0);
	 points: out std_logic_vector(7 downto 0)
    );
end logica_comb;

architecture arc_logica of logica_comb is
signal round_i, bonus_i : unsigned(3 downto 0);
signal nivel_i : unsigned(1 downto 0);
signal soma_base : unsigned(4 downto 0);
signal soma_nivel, soma_final : unsigned(7 downto 0);

begin

-- Converte para unsigned
round_i <= unsigned(round);
bonus_i <= unsigned(bonus);
nivel_i <= unsigned(nivel);

-- Soma básica (5 bits, pois pode dar até 30)
soma_base <= ("0" & round_i) + ("0" & bonus_i);

-- Ajuste por nível
with nivel_i select
soma_nivel <= soma_base + 0 when "00",
soma_base + 5 when "01",
soma_base + 10 when "10",
soma_base + 20 when others;

-- Verifica condição especial de bônus máximo
soma_final <= soma_nivel + soma_nivel when bonus_i = "1111" else soma_nivel;

-- Converte para saída std_logic_vector
points <= std_logic_vector(soma_final);

end arc_logica;
