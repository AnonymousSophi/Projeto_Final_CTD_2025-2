library ieee;
use ieee.std_logic_1164.all;

entity COMP_n_erros is
port(CODE_aux, USER: in std_logic_vector(14 downto 0);
	 erros: out std_logic_vector(14 downto 0)
    );
end COMP_n_erros;

architecture arc_COMP of COMP_n_erros is
begin

-- cada bit de "diferente" vira '1' quando CODE_aux(i) /= USER(i)
diferente <= CODE_aux xor USER;


end arc_COMP;
