library IEEE; 
use IEEE.Std_Logic_1164.all; 
use IEEE.std_logic_unsigned.all; 

entity mux_2x1_16bits is port
    (E0, E1: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(15 downto 0));
end mux_2x1_16bits;
        
architecture arqdtp of mux_2x1_16bits is
begin

    saida <=  E0   when sel <= '0' else
		   E1;
		   
end arqdtp;    
