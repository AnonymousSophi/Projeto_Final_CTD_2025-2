library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end ROM2;

architecture arc_ROM2 of ROM2 is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000110000000001" when address = "0000" else -- BA0
		  "100001000000100" when address = "0001" else -- E92
		  "100000010001000" when address = "0010" else -- E73
		  "010000000000110" when address = "0011" else -- D21
		  "000100000010010" when address = "0100" else -- B41
		  "000011000000100" when address = "0101" else -- A92
		  "000110000000010" when address = "0110" else -- BA1
		  "100000001001000" when address = "0111" else -- E63
		  "000010000001001" when address = "1000" else -- A30
		  "010000000110000" when address = "1001" else -- D54
		  "000011000000001" when address = "1010" else -- A90
		  "100000010000100" when address = "1011" else -- E82
		  "010000010000010" when address = "1100" else -- D81
		  "100000010000001" when address = "1101" else -- E80
		  "111000000000000" when address = "1110" else -- EDC
		  "000100000011000"; -- B43

end arc_ROM2;
