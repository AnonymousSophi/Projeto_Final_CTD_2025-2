library ieee;
use ieee.std_logic_1164.all;

entity COMP_0 is
port(Bonus_reg: in std_logic_vector(3 downto 0);
	 endgame: out std_logic
    );
end COMP_0;

architecture arc_COMP of COMP_0 is
begin

    process(Bonus_reg)
    begin
        if Bonus_reg = "0000" then
            endgame <= '1'; -- acaba jogo
        else
            endgame <= '0';
        end if;
    end process;

end arc_COMP;

