library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1a is
port(address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
    );
end ROM1a;

architecture arc_ROM1a of ROM1a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000000000000111" when address = "0000" else -- 210
		   "000000000001011" when address = "0001" else -- 310
		   "000000000010011" when address = "0010" else -- 410
		   "000000001000011" when address = "0011" else -- 610
		   "000000010000011" when address = "0100" else -- 710
		   "000000100000011" when address = "0101" else -- 810
		   "000001000000011" when address = "0110" else -- 910
		   "000010000000011" when address = "0111" else -- A10
		   "000100000000011" when address = "1000" else -- B10
		   "001000000000011" when address = "1001" else -- C10
		   "010000000000011" when address = "1010" else -- D10
		   "100000000000011" when address = "1011" else -- E10
		   "000000000001101" when address = "1100" else -- 320
		   "000000000010101" when address = "1101" else -- 420
		   "000000000100101" when address = "1110" else -- 520
		   "000000001000101" when address = "1111"; -- 620

end arc_ROM1a;
