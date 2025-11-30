library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3 is
port(address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
    );
end ROM3;

architecture arc_ROM3 of ROM3 is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "010000000001001" when address = "0000" else -- D30
		   "100000000001001" when address = "0001" else -- E30
		   "000000000110001" when address = "0010" else -- 540
		   "000000001010001" when address = "0011" else -- 640
		   "000000010010001" when address = "0100" else -- 740
		   "000000100010001" when address = "0101" else -- 840
		   "000001000010001" when address = "0110" else -- 940
		   "000010000010001" when address = "0111" else -- A40
		   "000100000010001" when address = "1000" else -- B40
		   "001000000010001" when address = "1001" else -- C40
		   "010000000010001" when address = "1010" else -- D40
		   "100000000010001" when address = "1011" else -- E40
		   "000000001100001" when address = "1100" else -- 650
		   "000000010100001" when address = "1101" else -- 750
		   "000000100100001" when address = "1110" else -- 850
		   "000001000100001" when address = "1111"; -- 950

end arc_ROM3;
