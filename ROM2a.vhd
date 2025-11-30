library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM2a;

architecture arc_ROM2a of ROM2a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000000010000101" when address = "0000" else -- 720
		   "000000100000101" when address = "0001" else -- 820
		   "000001000000101" when address = "0010" else -- 920
		   "000010000000101" when address = "0011" else -- A20
		   "000100000000101" when address = "0100" else -- B20
		   "001000000000101" when address = "0101" else -- C20
		   "010000000000101" when address = "0110" else -- D20
		   "100000000000101" when address = "0111" else -- E20
		   "000000000011001" when address = "1000" else -- 430
		   "000000000101001" when address = "1001" else -- 530
		   "000000001001001" when address = "1010" else -- 630
		   "000000010001001" when address = "1011" else -- 730
		   "000000100001001" when address = "1100" else -- 830
		   "000001000001001" when address = "1101" else -- 930
		   "000100000001001" when address = "1110" else -- B30
		   "001000000001001" when address = "1111"; -- C30

end arc_ROM2a;
