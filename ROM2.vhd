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

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "1010"	& "1111" & "0000" & "1111"	& "0111" & "1111" & "0100" & "1111" when address = "0000" else
--          A        des       0       des       7       des       4       des

          "1111"	& "0010" & "1111" & "1011"	& "1111" & "1000" & "1111" & "0110" when address = "0001" else
--         des        2       des       B       des       8       des       6

			 "0011"	& "1111" & "1111" & "1001"	& "0001" & "1111" & "1111" & "1111" when address = "0010" else
--          3        des      des       9        1       des      des      des

			 "1111"	& "1111" & "0101" & "1111"	& "1111" & "0000" & "1111" & "1100" when address = "0011" else
--         des       des       5       des      des       0       des        C

			 "1000"	& "1111" & "1111" & "1111"	& "0010" & "1111" & "1001" & "1111" when address = "0100" else
--          8        des      des      des       2       des       9       des

			 "1111"	& "0100" & "1111" & "0001"	& "1111" & "1111" & "1101" & "1111" when address = "0101" else
--         des        4       des       1       des      des        D      des

			 "0000"	& "1111" & "0111" & "1111"	& "1111" & "1111" & "1111" & "0101" when address = "0110" else
--          0        des       7       des      des      des      des        5			 
			 
			 "1111"	& "1111" & "0010" & "1111"	& "0110" & "1111" & "1111" & "1111" when address = "0111" else
--         des       des       2       des       6       des      des      des

			 "1001"	& "1111" & "1111" & "0011"	& "1111" & "1110" & "1111" & "1111" when address = "1000" else
--          9        des      des       3       des        E      des      des

			 "1111"	& "0110" & "1111" & "1111"	& "0100" & "1111" & "1111" & "0001" when address = "1001" else
--         des        6       des      des       4       des      des        1

			 "0010"	& "1111" & "1111" & "1111"	& "1111" & "0111" & "1111" & "1000" when address = "1010" else
--          2        des      des      des      des       7       des        8

			 "1111"	& "1011" & "1111" & "0000"	& "1111" & "1111" & "1111" & "1111" when address = "1011" else
--         des        B       des       0       des      des      des      des

			 "0100"	& "1111" & "1111" & "1110"	& "0011" & "1111" & "1111" & "1111" when address = "1100" else
--          4        des      des        E       3       des      des      des

			 "1111"	& "1111" & "1000" & "1111"	& "1111" & "0101" & "1111" & "0000" when address = "1101" else
--         des       des       8       des      des        5      des        0

			 "0111"	& "1111" & "1111" & "1111"	& "1011" & "1111" & "0001" & "1111" when address = "1110" else
--          7        des      des      des        B      des        1      des

			 "1111"	& "0000" & "1111" & "0010"	& "1111" & "1111" & "0110" & "1111";
--         des        0       des       2       des      des        6      des
			 
end arc_ROM2;
