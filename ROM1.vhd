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

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "1010"	& "1111" & "0011" & "1111"	& "1111" & "0110" & "1111" & "1101" when address = "0000" else
--          A        des       3       des      des       6       des        D

          "1111"	& "0101" & "1111" & "0001"	& "1111" & "1111" & "0110" & "1111" when address = "0001" else
--         des        5       des       1       des      des       6       des

			 "1111"	& "0000" & "1111" & "1111"	& "0100" & "1111" & "1001" & "1111" when address = "0010" else
--         des        0       des      des       4       des       9       des

			 "1011"	& "1111" & "1111" & "0110"	& "1111" & "1100" & "1111" & "1111" when address = "0011" else
--          B        des      des       6       des       C       des      des

			 "1111"	& "1111" & "0101" & "1111"	& "1111" & "0011" & "1111" & "1000" when address = "0100" else
--         des       des       5       des      des       3       des       8

			 "0110"	& "1111" & "1111" & "1110"	& "1111" & "1111" & "0001" & "1111" when address = "0101" else
--          6        des      des       E       des      des       1       des

			 "1111"	& "1110" & "1111" & "0100"	& "1000" & "1111" & "1111" & "1111" when address = "0110" else
--         des        E       des       4        8       des      des      des			 
			 
			 "0001"	& "1111" & "1111" & "1111"	& "1111" & "1011" & "1111" & "0101" when address = "0111" else
--          1        des      des      des      des       B       des       5

			 "1111"	& "1111" & "1001" & "1111"	& "0010" & "1111" & "1111" & "1100" when address = "1000" else
--         des       des       9       des       2       des      des        C

			 "1101"	& "1111" & "1111" & "0010"	& "1111" & "1111" & "0111" & "1111" when address = "1001" else
--          D        des      des       2       des      des        7      des

			 "1111"	& "0111" & "1111" & "1111"	& "1101" & "1111" & "1111" & "0000" when address = "1010" else
--         des        7       des      des       D       des      des        0

			 "1111"	& "1111" & "1111" & "0101"	& "0110" & "1111" & "1100" & "1111" when address = "1011" else
--         des       des      des       5        6       des        C      des

			 "0100"	& "1111" & "1111" & "1111"	& "1111" & "0111" & "1111" & "1001" when address = "1100" else
--          4        des      des      des      des        7       des       9

			 "1111"	& "1100" & "0010" & "1111"	& "1111" & "1111" & "1111" & "0110" when address = "1101" else
--         des        C        2       des      des      des      des        6

			 "0011"	& "1111" & "1111" & "1111"	& "1001" & "1111" & "1110" & "1111" when address = "1110" else
--          3        des      des      des        9       des       E      des

			 "1111"	& "0010" & "1111" & "1000"	& "1111" & "0101" & "1111" & "1111";
--         des        2       des       8       des        5      des      des
			 
end arc_ROM1;
