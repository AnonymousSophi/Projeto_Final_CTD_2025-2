library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.Numeric_Std.all;

entity subtracao is
port(E0 : in std_logic_vector(3 downto 0);
     E1 : in std_logic_vector(3 downto 0);
     resultado: out std_logic_vector(3 downto 0)
     );
end subtracao;

architecture arch1 of subtracao is
signal A, B : signed(3 downto 0);
signal R : signed(3 downto 0);
begin

-- converte entradas para signed
A <= signed(E0);
B <= signed(E1);

-- subtração em 2's complement
R <= A - B;

-- devolve em std_logic_vector
resultado <= std_logic_vector(R);

end arch1;


