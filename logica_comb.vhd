library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity logica_comb is port(

X, Bonus_reg: in std_logic_vector(3 downto 0);
nivel: in std_logic_vector(1 downto 0);        -- Sel
RESULT: out std_logic_vector(7 downto 0)
);
end logica_comb;

architecture arc_logica of logica_comb is
signal bonus_div: std_logic_vector(2 downto 0);
signal rodadas_div: std_logic_vector(1 downto 0);

begin

rodadas_div <= X (3 downto 2);

bonus_div <= Bonus_reg(3 downto 1);

RESULT <= '0' & nivel & bonus_div & rodadas_div;


end arc_logica;
