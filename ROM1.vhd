library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1 is
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end ROM1;

architecture arc_ROM1 of ROM1 is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000110001000000" when address = "0000" else -- BA6
		  "100000000110000" when address = "0001" else -- E54
		  "100000010001000" when address = "0010" else -- E73
		  "010000000000110" when address = "0011" else -- D21
		  "011000000000010" when address = "0100" else -- DC1
		  "000011000000100" when address = "0101" else -- A92
		  "100100000010000" when address = "0110" else -- EB4
		  "000101000100000" when address = "0111" else -- B95
		  "001000100000010" when address = "1000" else -- C81
		  "010000010000100" when address = "1001" else -- D72
		  "000011000000001" when address = "1010" else -- A90
		  "000100000000110" when address = "1011" else -- B21
		  "010000100010000" when address = "1100" else -- D95
		  "000000000100011" when address = "1101" else -- 510
		  "110000010000000" when address = "1110" else -- ED7
		  "000100000011000"; -- B43

end arc_ROM1;
