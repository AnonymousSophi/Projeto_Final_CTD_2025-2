library IEEE; 
use IEEE.Std_Logic_1164.all; 
use IEEE.std_logic_unsigned.all; 

entity reg_4bits is 
port (CLK:   in  std_logic;
	  RST:   in  std_logic;
	  N:   in  std_logic_vector(3 downto 0);
      S: out std_logic_vector(3 downto 0)
      ); 
end reg_4bits; 


architecture behv of reg_4bits is 

begin

	process (CLK, N)
	begin
		if (RST = '0') then
			S <= "0000";
		elsif rising_edge(CLK) then
			S <= N;
		end if;
	end process;

end behv;
