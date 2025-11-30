library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3a is
port(address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
    );
end ROM3a;

architecture arc_ROM3a of ROM3a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000010000100001" when address = "0000" else -- A50
		   "000100000100001" when address = "0001" else -- B50
		   "001000000100001" when address = "0010" else -- C50
		   "010000000100001" when address = "0011" else -- D50
		   "100000000100001" when address = "0100" else -- E50
		   "000000011000001" when address = "0101" else -- 760
		   "000000101000001" when address = "0110" else -- 860
		   "000001001000001" when address = "0111" else -- 960
		   "000010001000001" when address = "1000" else -- A60
		   "000100001000001" when address = "1001" else -- B60
		   "001000001000001" when address = "1010" else -- C60
		   "010000001000001" when address = "1011" else -- D60
		   "100000001000001" when address = "1100" else -- E60
		   "000000110000001" when address = "1101" else -- 870
		   "000001010000001" when address = "1110" else -- 970
		   "000010010000001" when address = "1111"; -- A70

end arc_ROM3a;
