library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3 is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(31 downto 0)
);
end ROM3;

architecture arc_ROM3 of ROM3 is
begin

--         HEX7      HEX6     HEX5     HEX4     HEX3     HEX2     HEX1     HEX0               round

output <= "0001"	& "1111" & "1001" & "1111"	& "1100" & "1111" & "0000" & "1111" when address = "0000" else
--          1        des       9       des        C      des       0       des

          "1111"	& "0011" & "1111" & "1111"	& "0101" & "1111" & "1111" & "0010" when address = "0001" else
--         des        3       des      des       5       des      des        2

			 "1110"	& "1111" & "0100" & "1111"	& "1111" & "1001" & "1111" & "1111" when address = "0010" else
--          E        des       4       des      des       9       des      des

			 "1111"	& "1000" & "1111" & "0111"	& "1111" & "1111" & "0011" & "1111" when address = "0011" else
--         des        8       des       7       des      des        3      des

			 "0110"	& "1111" & "1111" & "0001"	& "1111" & "1011" & "1111" & "1111" when address = "0100" else
--          6        des      des       1       des        B      des      des

			 "1111"	& "1111" & "0000" & "1111"	& "0010" & "1111" & "1111" & "1010" when address = "0101" else
--         des       des       0       des       2       des      des        A

			 "1100"	& "1111" & "1111" & "1111"	& "1000" & "1111" & "0101" & "1111" when address = "0110" else
--          C        des      des      des        8      des        5      des			 
			 
			 "1111"	& "0111" & "1111" & "0011"	& "1111" & "1111" & "1111" & "0100" when address = "0111" else
--         des        7       des       3       des      des      des        4

			 "0000"	& "1111" & "1111" & "0101"	& "1001" & "1111" & "1111" & "1111" when address = "1000" else
--          0        des      des       5        9      des      des      des

			 "1111"	& "0001" & "1111" & "1111"	& "1111" & "0110" & "1111" & "0111" when address = "1001" else
--         des        1       des      des      des        6      des        7

			 "1011"	& "1111" & "0010" & "1111"	& "1111" & "1111" & "1000" & "1111" when address = "1010" else
--          B        des       2       des      des      des        8      des

			 "1111"	& "1111" & "0111" & "1111"	& "0001" & "1111" & "1111" & "1001" when address = "1011" else
--         des       des       7       des        1      des      des        9

			 "0011"	& "1111" & "1111" & "1100"	& "1111" & "0000" & "1111" & "1111" when address = "1100" else
--          3        des      des        C      des       0       des      des

			 "1111"	& "0100" & "1111" & "1000"	& "1111" & "1111" & "0010" & "1111" when address = "1101" else
--         des        4       des       8       des      des        2      des

			 "1001"	& "1111" & "1111" & "1111"	& "0110" & "1111" & "1111" & "0001" when address = "1110" else
--          9        des      des      des       6       des      des        1

			 "1111"	& "1010" & "1111" & "1001"	& "1111" & "0011" & "1111" & "1111";
--         des        A       des       9       des        3      des      des
			 
end arc_ROM3;
