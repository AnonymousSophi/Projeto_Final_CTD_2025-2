library IEEE;
use IEEE.Std_Logic_1164.all;
use ieee.std_logic_unsigned.all; 
use ieee.std_logic_arith.all;

entity logica_comb is
port(X, Bonus_reg: in std_logic_vector(3 downto 0);
	 Sel: in std_logic_vector(1 downto 0);
	 RESULT: out std_logic_vector(7 downto 0)
    );
end logica_comb;
